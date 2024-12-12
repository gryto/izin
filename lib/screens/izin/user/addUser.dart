import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/izin/izin_cubit.dart';
import '../../../bloc/izin/izin_state.dart';
import '../../../utils/constants/colors.dart';
import '../../components/user_add.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  late IzinCubit izinCubit;
  @override
  void initState() {
    super.initState();
    izinCubit = context.read<IzinCubit>();
    // izinCubit.initUserIzinData(context);
    // izinCubit.initIzinData(context);
    izinCubit.initUsetIzinData(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "RegisterUser",
        ),
      ),
      body: BlocConsumer<IzinCubit, IzinState>(
        listener: (context, state) {
          print("State changed: $state");

          if (state.isUpdateSuccess) {
            AwesomeDialog(
              dismissOnTouchOutside: false,
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.topSlide,
              title: 'Success',
              desc: 'Data Berhasil Diupdate !!!',
              btnOkOnPress: () async {
                izinCubit.refreshIzinDataUser(context);
              },
            ).show();
          }
          
        },
        builder: (context, state) {
          print("Building with state: ${state.izinAll}");
          return Column(
            children: [
              if (state.warningMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.warningMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              state.userIzinList.isNotEmpty
                  ? Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(
                            16.0), // Optional padding for the container
                        child: Column(
                          children: [
                            // Tombol "Select All"
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0), // Spasi antar tombol
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.green, // Sesuaikan warna tombol
                                ),
                                onPressed: () {
                                  // Ambil semua ID dari daftar userIzinList
                                  final allIds = state.userIzinList
                                      .map((izin) => izin.id!)
                                      .toList();

                                  context
                                      .read<IzinCubit>()
                                      .toggleSelectAll(allIds);

                                  print("Tombol Select All diklik");
                                  print("Semua ID: $allIds");
                                },
                                child: Text(
                                  state.selectedIds.length ==
                                          state.userIzinList.length
                                      ? "Deselect All"
                                      : "Select All",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.userIzinList.length,
                                itemBuilder: (context, index) {
                                  final izin = state.userIzinList[index];
                                  final isSelected =
                                      state.selectedIds.contains(izin.id);

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15, top: 5, bottom: 5),
                                    child: UserAddCard(
                                      title: izin.name,
                                      color: Colors.blueAccent,
                                      colorbg: Colors.white,
                                      colorTitle: Colors.black,
                                      isSelected:
                                          isSelected, // Kirim status pilihan
                                      onClick: () {
                                        context
                                            .read<IzinCubit>()
                                            .toggleSelection(izin.id!);
                                        print("id yg dipilih: ${izin.id}");
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),

                            // Add the "Save" button below the ListView
                            Padding(
                              padding: const EdgeInsets.only(
                                  top:
                                      16.0), // Space between the list and button
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorApp
                                      .button, // Adjust the button color as needed
                                ),
                                onPressed: () {
                                  // Ambil daftar ID yang dipilih
                                  final selectedIds = context
                                      .read<IzinCubit>()
                                      .state
                                      .selectedIds;

                                  print("semua lidt id");
                                  print(selectedIds);

                                  if (selectedIds.isNotEmpty) {
                                    context
                                        .read<IzinCubit>()
                                        .initAddUserData(context, selectedIds);
                                    print('Selected IDs: $selectedIds');
                                  } else {
                                    print('No IDs selected');
                                  }
                                },
                                child: const Text(
                                  "Save",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Image.asset("assets/images/no_task.jpg"),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Anda belum memiliki tugas, hubungi atasan anda untuk assign task',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
            ],
          );
        },
      ),
    );
  }
}
