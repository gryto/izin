import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../bloc/izin/izin_cubit.dart';
import '../../../bloc/izin/izin_state.dart';
import '../../../model/submissionAll.dart';
import '../../../model/user.dart';
import '../../../utils/constants/colors.dart';
import '../../components/textFormField.dart';

enum ActionMode { add, edit, view }

class DetailSubmissionRow extends StatefulWidget {
  final String type;
  final SubmissionAll izin;
  final User user;

  const DetailSubmissionRow({
    super.key,
    required this.type,
    required this.izin,
    required this.user,
  });

  @override
  State<DetailSubmissionRow> createState() => _DetailSubmissionRowState();
}

class _DetailSubmissionRowState extends State<DetailSubmissionRow> {
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
    print("widget detail submission");
    print(widget.izin.readByAdmin);
    print(widget.user);
    // print(widget.role);
    print("ini data paket => ${widget.izin.id}");
    izinCubit.getUserRole();
    izinCubit.initUserIzinData(context);
    if (widget.type == "edit" || widget.type == "detail") {
      context.read<IzinCubit>().parsingData(widget.izin, widget.user);
    } else {
       context.read<IzinCubit>().parsingData(widget.izin, widget.user);
      // context.read<IzinCubit>().resetForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> options = [
      'Datang Terlambat',
      'Pulang lebih awal',
      'Tugas luar kantor',
      'Dinas luar kota',
      'Sakit',
      'Lain-lain'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengajuan Izin"),
      ),
      body: BlocConsumer<IzinCubit, IzinState>(listener: (context, state) {
        if (state.message.isNotEmpty &&
            state.titleMessage.isNotEmpty &&
            state.typeMessage.isNotEmpty) {
          AwesomeDialog(
            dismissOnTouchOutside: false,
            context: context,
            dialogType: state.typeMessage == 'success'
                ? DialogType.success
                : state.typeMessage == 'warning'
                    ? DialogType.warning
                    : DialogType.error,
            animType: AnimType.topSlide,
            title: state.titleMessage,
            desc: state.message,
            btnOkOnPress: () async {
              // izinCubit.resetForm();
              // profileCubit.refreshData(context);
            },
          ).show();
        }
      }, builder: (context, state) {
        // Assign values from state to controllers if data is available
        // state.ctrlName.text = state.userIzin.name ?? "";
        // state.ctrlDivision.text = state.userIzin.jabatan ?? "";
        // state.ctrlEndTime.text = "Selesai";

        String convertDateFormat(String date) {
          // Parse the input date string (dd/MM/yyyy)
          DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);

          // Format the DateTime object into the new format (yyyy-MM-dd)
          String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

          return formattedDate;
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
                          readOnly: true,
                          enable: false,
                          title: "Nama",
                          focusNode: _focusNodes[0],
                          controller: state.ctrlName,
                          onClick: () async {
                            //
                          },
                          onChanged: (String value) {
                            state.ctrlName.text = value;
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormFoeldActivity(
                          readOnly: true,
                          enable: false,
                          title: "Divisi",
                          focusNode: _focusNodes[1],
                          controller: state.ctrlDivision,
                          onClick: () async {
                            //
                          },
                          onChanged: (String value) {
                            state.ctrlDivision.text = value;
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormFoeldActivity(
                          readOnly: true,
                          enable: false,
                          title: "Dari Tanggal",
                          focusNode: _focusNodes[1],
                          controller: state.ctrlStartDate,
                          onClick: widget.izin.status == "Pending"
                              ? () async {
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
                                        state.ctrlStartDate.text =
                                            formattedDate;
                                        print("value");
                                        print(state.ctrlStartDate.text);
                                      },
                                    );
                                  }
                                }
                              : () async {},
                          onChanged: (String value) {
                            state.ctrlStartDate.text = value;
                            // print("valueygdipilih");
                            // print(state.ctrlStartDate.text);
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormFoeldActivity(
                          readOnly: true,
                          enable: false,
                          title: "Sampai Tanggal",
                          focusNode: _focusNodes[2],
                          controller: state.ctrlEndDate,
                          onClick: widget.izin.status == "Pending"
                              ? () async {
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
                                }
                              : () async {},
                          onChanged: (String value) {
                            state.ctrlEndDate.text = value;
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormFoeldActivity(
                          readOnly: true,
                          enable: false,
                          title: "Dari Jam",
                          focusNode: _focusNodes[4],
                          controller: state.ctrlStartTime,
                          onClick: widget.izin.status == "Pending"
                              ? () async {
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay
                                        .now(), // Mulai dengan jam sekarang
                                  );

                                  if (pickedTime != null) {
                                    // Format waktu yang dipilih dan masukkan ke controller
                                    final now = DateTime.now();
                                    final selectedTime = DateTime(
                                        now.year,
                                        now.month,
                                        now.day,
                                        pickedTime.hour,
                                        pickedTime.minute);
                                    String formattedTime = DateFormat('HH:mm')
                                        .format(selectedTime);

                                    setState(() {
                                      state.ctrlStartTime.text = formattedTime;
                                      print("waktu yg dipilih");
                                      print(formattedTime);
                                    });
                                  }
                                }
                              : () async {},
                          onChanged: (String value) {
                            state.ctrlStartTime.text = value;
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormFoeldActivity(
                          readOnly: true,
                          enable: false,
                          title: "Sampai Jam",
                          focusNode: _focusNodes[5],
                          controller: state.ctrlEndTime,
                          onClick: () async {},
                          onChanged: (String value) {
                            state.ctrlEndTime.text = value;
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormFoeldActivity(
                          readOnly: true,
                          enable: false,
                          title: "Alasan",
                          focusNode: _focusNodes[6],
                          controller: state.ctrlReason,
                          onClick: widget.izin.status == "Pending"
                              ? () async {
                                  // Menampilkan bottom sheet dengan daftar opsi
                                  await showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: options.map((String option) {
                                          return ListTile(
                                            title: Text(option),
                                            onTap: () {
                                              state.ctrlReason.text = option;
                                              Navigator.pop(
                                                  context); // Menutup modal setelah memilih
                                            },
                                          );
                                        }).toList(),
                                      );
                                    },
                                  );
                                }
                              : () async {},
                          onChanged: (String value) {
                            state.ctrlReason.text = value;
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormFoeldActivity(
                          readOnly: true,
                          enable: false,
                          title: "Deskripsi",
                          focusNode: _focusNodes[7],
                          controller: state.ctrlDescription,
                          onClick: () async {},
                          onChanged: (String value) {
                            state.ctrlDescription.text = value;
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        state.userRole == "3" &&
                                    widget.izin.statusAdmin.toString() == "1" ||
                                state.userRole == "1" &&
                                    widget.izin.statusSuperadmin.toString() ==
                                        "1"
                            ? Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey,
                                      ),
                                      child: const Text(
                                        'Back',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorApp.button,
                                      ),
                                      child: const Text(
                                        'Approve',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        print("inisblmaproove");

                                        AwesomeDialog(
                                          dismissOnTouchOutside: false,
                                          context: context,
                                          dialogType: DialogType.info,
                                          animType: AnimType.topSlide,
                                          title: "Konfirmasi",
                                          desc:
                                              "Apakah anda yakin ingin approve data ???",
                                          btnCancelOnPress: () {},
                                          btnOkOnPress: () async {
                                            izinCubit.initUpdateSubmissionData(
                                                context,
                                                widget.izin,
                                                state.userIzin.username);
                                            // }
                                          },
                                        ).show();
                                      },
                                    ),
                                  )
                                ],
                              )
                            : (Container()),
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
