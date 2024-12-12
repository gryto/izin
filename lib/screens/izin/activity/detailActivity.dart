import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../bloc/izin/izin_cubit.dart';
import '../../../bloc/izin/izin_state.dart';
import '../../../utils/constants/colors.dart';
import '../../components/textFormField.dart';

enum ActionMode { add, edit, view }

class DetailActivity extends StatefulWidget {
  final ActionMode actionMode; // Menambahkan parameter actionMode
  final id,
      name,
      startDate,
      endDate,
      startTime,
      endTime,
      reason,
      description,
      status;

  const DetailActivity(
      {super.key,
      required this.actionMode,
      required this.id,
      required this.name,
      required this.startDate,
      required this.endDate,
      required this.startTime,
      required this.endTime,
      required this.reason,
      required this.status,
      required this.description});

  @override
  State<DetailActivity> createState() => _DetailActivityState();
}

class _DetailActivityState extends State<DetailActivity> {
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
    izinCubit.initUserIzinData(context);
    izinCubit.initIzinData(context);
  }

  @override
  Widget build(BuildContext context) {
    // Set the title based on the actionMode
    String title = '';

    switch (widget.actionMode) {
      case ActionMode.add:
        title = 'Tambah Pengajuan Izin';
        break;
      case ActionMode.edit:
        title = 'Edit Pengajuan Izin';
        break;
      case ActionMode.view:
        title = 'Detail Pengajuan Izin';
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
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
              izinCubit.resetForm();
              // profileCubit.refreshData(context);
            },
          ).show();
        }
      }, builder: (context, state) {
        // Assign values from state to controllers if data is available
        state.ctrlName.text = state.userIzin.name ?? "";
        state.ctrlDivision.text = state.userIzin.jabatan ?? "";
        state.ctrlEndTime.text = "Selesai";

        String convertDateFormat(String date) {
          // Parse the input date string (dd/MM/yyyy)
          DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);

          // Format the DateTime object into the new format (yyyy-MM-dd)
          String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

          return formattedDate;
        }

        if (widget.actionMode == ActionMode.add) {
          if (state.ctrlStartDate.text.isEmpty &&
              state.ctrlEndDate.text.isEmpty) {
            final currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
            state.ctrlStartDate.text = currentDate;
            state.ctrlEndDate.text = currentDate;
          }
          if (state.ctrlStartTime.text.isEmpty) {
            final currentTime = DateFormat('HH:mm').format(DateTime.now());
            state.ctrlStartTime.text = currentTime;
          }
        } else if (widget.actionMode == ActionMode.view &&
            widget.status == "Pending") {
          izinCubit.state.ctrlName.text = widget.name;

          if (state.ctrlStartDate.text.isEmpty &&
              state.ctrlEndDate.text.isEmpty) {
            state.ctrlStartDate.text = convertDateFormat(widget.startDate);
            ;
            state.ctrlEndDate.text = convertDateFormat(widget.endDate);
          }
          if (state.ctrlStartTime.text.isEmpty) {
            state.ctrlStartTime.text = widget.startTime;
          }

          izinCubit.state.ctrlEndTime.text = widget.endTime;
          izinCubit.state.ctrlReason.text = widget.reason;
          izinCubit.state.ctrlDescription.text = widget.description;
        } else {
          izinCubit.state.ctrlName.text = widget.name;
          izinCubit.state.ctrlStartDate.text = widget.startDate;
          izinCubit.state.ctrlEndDate.text = widget.endDate;
          izinCubit.state.ctrlStartTime.text = widget.startTime;
          izinCubit.state.ctrlEndTime.text = widget.endTime;
          izinCubit.state.ctrlReason.text = widget.reason;
          izinCubit.state.ctrlDescription.text = widget.description;
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
                          readOnly: widget.actionMode == ActionMode.view &&
                                  widget.status != "Pending"
                              ? true
                              : false,
                          enable: widget.actionMode == ActionMode.view &&
                                  widget.status != "Pending"
                              ? false
                              : true,
                          title: "Dari Tanggal",
                          focusNode: _focusNodes[1],
                          controller: state.ctrlStartDate,
                          onClick: (widget.actionMode == ActionMode.add) ||
                                  (widget.actionMode == ActionMode.view &&
                                      widget.status == "Pending")
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
                          readOnly: widget.actionMode == ActionMode.view &&
                                  widget.status != "Pending"
                              ? true
                              : false,
                          enable: widget.actionMode == ActionMode.view &&
                                  widget.status != "Pending"
                              ? false
                              : true,
                          title: "Sampai Tanggal",
                          focusNode: _focusNodes[2],
                          controller: state.ctrlEndDate,
                          onClick: (widget.actionMode == ActionMode.add) ||
                                  (widget.actionMode == ActionMode.view &&
                                      widget.status == "Pending")
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
                          readOnly: widget.actionMode == ActionMode.view &&
                                  widget.status != "Pending"
                              ? true
                              : false,
                          enable: widget.actionMode == ActionMode.view &&
                                  widget.status != "Pending"
                              ? false
                              : true,
                          title: "Dari Jam",
                          focusNode: _focusNodes[4],
                          controller: state.ctrlStartTime,
                          onClick: (widget.actionMode == ActionMode.add) ||
                                  (widget.actionMode == ActionMode.view &&
                                      widget.status == "Pending")
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
                          readOnly: widget.actionMode == ActionMode.view &&
                                  widget.status != "Pending"
                              ? true
                              : false,
                          enable: widget.actionMode == ActionMode.view &&
                                  widget.status != "Pending"
                              ? false
                              : true,
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
                          readOnly: widget.actionMode == ActionMode.view &&
                                  widget.status != "Pending"
                              ? true
                              : false,
                          enable: widget.actionMode == ActionMode.view &&
                                  widget.status != "Pending"
                              ? false
                              : true,
                          title: "Alasan",
                          focusNode: _focusNodes[6],
                          controller: state.ctrlReason,
                          onClick: (widget.actionMode == ActionMode.add) ||
                                  (widget.actionMode == ActionMode.view &&
                                      widget.status == "Pending")
                              ? () async {
                                  // Menampilkan bottom sheet dengan daftar opsi
                                  await showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: state.optionIzin
                                            .map((String option) {
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
                          readOnly: widget.actionMode == ActionMode.view &&
                                  widget.status != "Pending"
                              ? true
                              : false,
                          enable: widget.actionMode == ActionMode.view &&
                                  widget.status != "Pending"
                              ? false
                              : true,
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
                        if (widget.actionMode == ActionMode.view &&
                            widget.status == "Pending")
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 20),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                  ),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    final id = widget.id;
                                    final startDate = state.ctrlStartDate.text;
                                    final endDate = state.ctrlEndDate.text;
                                    final startTime = state.ctrlStartTime.text;
                                    final endTime = state.ctrlEndTime.text;
                                    final reason = state.ctrlReason.text;
                                    final description =
                                        state.ctrlDescription.text;
                                    final username = state.userIzin.username;

                                    AwesomeDialog(
                                      dismissOnTouchOutside: false,
                                      context: context,
                                      dialogType: DialogType.info,
                                      animType: AnimType.topSlide,
                                      title: "Konfirmasi",
                                      desc:
                                          "Apakah anda yakin ingin cancel data ???",
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () async {
                                        // profileCubit.refreshData(context);
                                        izinCubit.initCancelIzinData(
                                            context,
                                            id,
                                            startDate,
                                            endDate,
                                            startTime,
                                            endTime,
                                            reason,
                                            description,
                                            username);
                                        // }
                                      },
                                    ).show();
                                  },
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
                                    'Save',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    final id = widget.id;
                                    final startDate = state.ctrlStartDate.text;
                                    final endDate = state.ctrlEndDate.text;
                                    final startTime = state.ctrlStartTime.text;
                                    final endTime = state.ctrlEndTime.text;
                                    final reason = state.ctrlReason.text;
                                    final description =
                                        state.ctrlDescription.text;
                                    final username = state.userIzin.username;

                                    /////
                                    AwesomeDialog(
                                      dismissOnTouchOutside: false,
                                      context: context,
                                      dialogType: DialogType.info,
                                      animType: AnimType.topSlide,
                                      title: "Konfirmasi",
                                      desc:
                                          "Apakah anda yakin ingin update data ???",
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () async {
                                        // profileCubit.refreshData(context);
                                        izinCubit.initUpdateIzinData(
                                            context,
                                            id,
                                            startDate,
                                            endDate,
                                            startTime,
                                            endTime,
                                            reason,
                                            description,
                                            username);
                                        // }
                                      },
                                    ).show();
                                  },
                                ),
                              )
                            ],
                          )
                        else if (widget.actionMode == ActionMode.add)
                          Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorApp.button,
                                ),
                                child: const Text(
                                  'Tambah',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                onPressed: () {
                                  final startDate = state.ctrlStartDate.text;
                                  final endDate = state.ctrlEndDate.text;
                                  final startTime = state.ctrlStartTime.text;
                                  final endTime = state.ctrlEndTime.text;
                                  final reason = state.ctrlReason.text;
                                  final description =
                                      state.ctrlDescription.text;
                                  final username = state.userIzin.username;

                                  print('tampilkan dialog');
                                  AwesomeDialog(
                                    dismissOnTouchOutside: false,
                                    context: context,
                                    dialogType: DialogType.info,
                                    animType: AnimType.topSlide,
                                    title: "Konfirmasi",
                                    desc:
                                        "Apakah anda yakin ingin simpan data ???",
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () async {
                                      // profileCubit.refreshData(context);
                                      izinCubit.initAddIzinData(
                                          context,
                                          startDate,
                                          endDate,
                                          startTime,
                                          endTime,
                                          reason,
                                          description,
                                          username);
                                      // switch (widget.type) {
                                      //   case 'edit':
                                      //     context
                                      //         .read<PaketCubit>()
                                      //         .updatePaket(widget.paket);
                                      //     break;
                                      //   case 'tambah':
                                      //     context
                                      //         .read<PaketCubit>()
                                      //         .savePaket();
                                      //     break;
                                      //   default:
                                      // }
                                    },
                                  ).show();
                                }),
                          )
                        else
                          (Container()),
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
