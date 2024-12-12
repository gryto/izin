import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../bloc/izin/izin_cubit.dart';
import '../../../bloc/izin/izin_state.dart';
import '../../../utils/constants/colors.dart';
import '../../components/textFormField.dart';
import 'donlodReport.dart';

// enum ActionMode { add, edit, view }

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  late IzinCubit izinCubit;
  @override
  void initState() {
    super.initState();
    izinCubit = context.read<IzinCubit>();
    izinCubit.initUsetIzinData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<IzinCubit, IzinState>(
          listener: (context, state) {},
          builder: (context, state) {
            // Assign values from state to controllers if data is available
            state.ctrlName.text = state.userIzin.name ?? "";
            state.ctrlDivision.text = state.userIzin.jabatan ?? "";
            state.ctrlEndTime.text = "Selesai";

            String convertDateFormat(String date) {
              // Parse the input date string (dd/MM/yyyy)
              DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);

              // Format the DateTime object into the new format (yyyy-MM-dd)
              String formattedDate =
                  DateFormat('dd/MM/yyyy').format(parsedDate);

              return formattedDate;
            }

            if (state.ctrlStartDate.text.isEmpty &&
                state.ctrlEndDate.text.isEmpty) {
              final currentDate =
                  DateFormat('dd/MM/yyyy').format(DateTime.now());
              state.ctrlStartDate.text = currentDate;
              state.ctrlEndDate.text = currentDate;
            }
            if (state.ctrlStartTime.text.isEmpty) {
              final currentTime = DateFormat('HH:mm').format(DateTime.now());
              state.ctrlStartTime.text = currentTime;
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 1.0,
                            spreadRadius: 0.5,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormFoeldActivity(
                              readOnly: false,
                              enable: true,
                              title: "Dari Tanggal",
                              focusNode: _focusNodes[1],
                              controller: state.ctrlStartDate,
                              onClick: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(
                                      2025), // Ubah sesuai dengan batas tanggal yang diinginkan
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          primary: Colors.blue,
                                          onPrimary: Colors.white,
                                          onSurface: Colors.black,
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                              foregroundColor: Colors.amber),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('dd/MM/yyyy')
                                          .format(pickedDate);

                                  setState(
                                    () {
                                      state.ctrlStartDate.text = formattedDate;
                                      print("value");
                                      print(state.ctrlStartDate.text);
                                    },
                                  );
                                }
                              },
                              onChanged: (String value) {},
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormFoeldActivity(
                              readOnly: false,
                              enable: true,
                              title: "Sampai Tanggal",
                              focusNode: _focusNodes[2],
                              controller: state.ctrlEndDate,
                              onClick: () async {
                                print(
                                    "TextFormField clicked"); // Debugging check
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(
                                      2025), // Ubah sesuai dengan batas tanggal yang diinginkan
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          primary: Colors.blue,
                                          onPrimary: Colors.white,
                                          onSurface: Colors.black,
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                              foregroundColor: Colors.amber),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('dd/MM/yyyy')
                                          .format(pickedDate);

                                  setState(
                                    () {
                                      state.ctrlEndDate.text = formattedDate;
                                      print("value");
                                      print(state.ctrlEndDate.text);
                                    },
                                  );
                                }
                              },
                              onChanged: (String value) {},
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormFoeldActivity(
                              readOnly: false,
                              enable: true,
                              title: "Nama Karyawan",
                              focusNode: _focusNodes[6],
                              controller: state.ctrlReason,
                              onClick: () async {
                                // Menampilkan bottom sheet dengan daftar opsi
                                await showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return GestureDetector(
                                      onTap: () => Navigator.of(context).pop(),
                                      child: Container(
                                        color: const Color.fromRGBO(
                                            0, 0, 0, 0.001),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: DraggableScrollableSheet(
                                            initialChildSize: 0.8,
                                            minChildSize: 0.2,
                                            maxChildSize: 0.95,
                                            builder: (_, controller) {
                                              return Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(25.0),
                                                    topRight:
                                                        Radius.circular(25.0),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.remove,
                                                      color: Colors.grey[600],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text(
                                                      "Pencarian",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const Divider(
                                                      thickness: 2,
                                                    ),
                                                    Expanded(
                                                      child:
                                                          SingleChildScrollView(
                                                        controller: controller,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 2,
                                                                  left: 15,
                                                                  right: 15,
                                                                  bottom: 15),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: state
                                                                .listUser
                                                                .map((String
                                                                    option) {
                                                              print(
                                                                  "listusernamaorhg");
                                                              print(state
                                                                  .listUser);
                                                              return ListTile(
                                                                title: Text(
                                                                    option),
                                                                onTap: () {
                                                                  // state.ctrlReason
                                                                  //         .text =
                                                                  //     option;
                                                                  // Navigator.pop(
                                                                  //     context); // Menutup modal setelah memilih
                                                                  // Cari user berdasarkan name yang dipilih
                                                                  final selectedUser = state
                                                                      .userIzinList
                                                                      .firstWhere((user) =>
                                                                          user.name ==
                                                                          option);

                                                                  // Simpan name dan username dari user yang dipilih
                                                                  state.ctrlReason
                                                                          .text =
                                                                      option;
                                                                  izinCubit
                                                                      .emit(
                                                                    state
                                                                        .copyWith(
                                                                      selectedUsername:
                                                                          selectedUser
                                                                              .username,
                                                                      selectedName:
                                                                          selectedUser
                                                                              .name,
                                                                    ),
                                                                  );

                                                                  // Tutup modal setelah memilih
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              onChanged: (String value) {
                                state.ctrlReason.text = value;
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorApp.button,
                                    ),
                                    child: const Text(
                                      'Generate',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      final startDate =
                                          state.ctrlStartDate.text;
                                      final endDate = state.ctrlEndDate.text;
                                      final username = state.selectedUsername;
                                      final name = state.selectedName;

                                      String convertDateFormat(String date) {
                                        // Parse the input date string (dd/MM/yyyy)
                                        DateTime parsedDate =
                                            DateFormat('dd/MM/yyyy')
                                                .parse(date);

                                        // Format the DateTime object into the new format (yyyy-MM-dd)
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(parsedDate);

                                        return formattedDate;
                                      }

                                      var start_date =
                                          convertDateFormat(startDate);
                                      var end_date = convertDateFormat(endDate);

                                      izinCubit.initGenerateData(
                                          context,
                                          startDate,
                                          endDate,
                                          state
                                              .selectedUsername // Kirimkan username
                                          );

                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DownloadReportPage(
                                            name: "$name.pdf",
                                            path:
                                                "https://izin.hanatekindo.com/generate-laporan-izin?&start_date=$start_date&end_date=$end_date&username=$username",
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
