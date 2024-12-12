import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../bloc/izin/izin_cubit.dart';
import '../../../bloc/izin/izin_state.dart';
import '../../../router/app_routes.dart';
import '../../../utils/constants/colors.dart';
import '../../components/user_card.dart';
import 'addUser.dart';

abstract class SearchEvent {}

class SearchKeywordChanged extends SearchEvent {
  final String keyword;

  SearchKeywordChanged(this.keyword);
}

class UserIzinPage extends StatefulWidget {
  const UserIzinPage({super.key});

  @override
  State<UserIzinPage> createState() => _UserIzinPageState();
}

class _UserIzinPageState extends State<UserIzinPage> {
  late IzinCubit izinCubit;
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    print("Initializing IzinCubit");
    izinCubit = context.read<IzinCubit>();
    izinCubit.initUsetIzinData(context);
  }

  bool isProcess = true;
  List listData = [];

  final fieldKeyword = TextEditingController();
  final List<FocusNode> _focusNodes = [
    FocusNode(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 67, 128, 252),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              'Tambah User',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddUserPage(),
                ),
              );
            },
          ),
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
          // if (context.mounted) {
          //   context
          //       .go("/${Routes.MAINPAGE}/${Routes.IZIN}");
          // }
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
              state.searchResults.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: state.searchResults.length,
                        itemBuilder: (context, index) {
                          final izin = state.searchResults[index];

                          String status = izin.role == "2"
                              ? "Administrator"
                              : izin.role == "3"
                                  ? "Supervisor"
                                  : izin.role == "4"
                                      ? "user"
                                      : izin.role == "1"
                                          ? "SuperAdmin"
                                          : "";

                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 5, bottom: 5),
                            child: UserCard(
                              icon: Icons.abc,
                              title: izin.name,
                              color: Colors.blueAccent,
                              colorbg: Colors.white,
                              colorTitle: Colors.black,
                              onClick: () {},
                              progress: status,
                              reason: izin.email,
                            ),
                          );
                        },
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
      floatingActionButton: BlocBuilder<IzinCubit, IzinState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                builder: (
                  BuildContext context,
                ) {
                  return BottomSheet(
                    enableDrag: false,
                    onClosing: () {},
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (BuildContext context, setState) => SafeArea(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  10),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text(
                                        'Pencarian',
                                        style: TextStyle(
                                            color: ColorApp.basic,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Divider(
                                        thickness: 2,
                                        color: ColorApp.basic,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextField(
                                        controller: searchController,
                                        decoration: InputDecoration(
                                          labelText: 'Masukkan Keyword',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onChanged: (query) {
                                          // Update the search query when the text changes
                                          izinCubit.searchIzin(query);
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorApp.button,
                                    ),
                                    child: const Text(
                                      'Cari',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      // Trigger search when the button is pressed
                                      izinCubit
                                          .searchIzin(searchController.text);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
            backgroundColor: const Color.fromARGB(255, 67, 128, 252),
            child: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
