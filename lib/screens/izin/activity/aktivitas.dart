import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../bloc/izin/izin_cubit.dart';
import '../../../bloc/izin/izin_state.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/constantStyle.dart';
import '../../components/activity_card.dart';
import 'detailActivity.dart';
import 'donlodActivity.dart';

class AktivitasIzin extends StatefulWidget {
  const AktivitasIzin({super.key});

  @override
  State<AktivitasIzin> createState() => _AktivitasIzinState();
}

class _AktivitasIzinState extends State<AktivitasIzin> {
  late IzinCubit izinCubit;
  @override
  void initState() {
    super.initState();
    // Panggil initData saat widget pertama kali diinisialisasi
    // profileCubit = BlocProvider.of<ProfileCubit>(context); // untuk
    print("Initializing IzinCubit");
    izinCubit = context.read<IzinCubit>();
    izinCubit.initIzinData(context);
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
              'Tambah',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailActivity(
                    actionMode: ActionMode.add,
                    id: "",
                    name: "",
                    startDate: "",
                    endDate: "",
                    startTime: "",
                    endTime: "",
                    reason: "",
                    description: "", status: null,
                    // idBidang: dropdownValue,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      body: BlocConsumer<IzinCubit, IzinState>(
        listener: (context, state) {
          print("State changed: $state");

          // if (state.isUpdateSuccess) {
          //   AwesomeDialog(
          //     dismissOnTouchOutside: false,
          //     context: context,
          //     dialogType: DialogType.success,
          //     animType: AnimType.topSlide,
          //     title: 'Success',
          //     desc: 'Data Berhasil Diupdate !!!',
          //     btnOkOnPress: () async {
          //       izinCubit.refreshIzinData(context);
          //     },
          //   ).show();
          // }
          // if (state.message.isNotEmpty &&
          //     state.titleMessage.isNotEmpty &&
          //     state.typeMessage.isNotEmpty) {
          //   AwesomeDialog(
          //     dismissOnTouchOutside: false,
          //     context: context,
          //     dialogType: state.typeMessage == 'success'
          //         ? DialogType.success
          //         : state.typeMessage == 'warning'
          //             ? DialogType.warning
          //             : DialogType.error,
          //     animType: AnimType.topSlide,
          //     title: state.titleMessage,
          //     desc: state.message,
          //     btnOkOnPress: () async {
          //       // profileCubit.refreshData(context);
          //     },
          //   ).show();
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
              state.izinAll.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: state.izinAll.length,
                        itemBuilder: (context, index) {
                          final izin = state.izinAll[index];

                          print("Rendering izin: $izin");

                          print("print izin list di listbuilder");
                          print(izin);
                          var statusPending = (izin.status == "1" &&
                              izin.statusAdmin == "1" &&
                              izin.statusSuperadmin == "1");
                          var statusSuperAdmin = (izin.status == "1" &&
                              izin.statusAdmin == "1" &&
                              izin.statusSuperadmin == "2");
                          var statusAdmin = (izin.status == "1" &&
                              izin.statusAdmin == "2" &&
                              izin.statusSuperadmin == "1");
                          var statusDone = (izin.status == "2" &&
                              izin.statusAdmin == "2" &&
                              izin.statusSuperadmin == "2");
                          var statusCanceled = (izin.status == "3" &&
                              izin.statusAdmin == "2" &&
                              izin.statusSuperadmin == "2");

                          String convertDateFormat(String? date) {
                            // Parse the input date string (dd/MM/yyyy)
                            DateTime parsedDate =
                                DateFormat('yyyy-MM-dd').parse(date!);

                            // Format the DateTime object into the new format (yyyy-MM-dd)
                            String formattedDate =
                                DateFormat('dd/MM/yyyy').format(parsedDate);

                            return formattedDate;
                          }

                          String status = statusPending
                              ? "Pending"
                              : statusSuperAdmin
                                  ? "Approved"
                                  : statusAdmin
                                      ? "Approved"
                                      : statusDone
                                          ? "Approved"
                                          : "Canceled";

                          String subtitel = statusPending
                              ? "Pending"
                              : statusSuperAdmin
                                  ? "Checked by SuperAdmin"
                                  : statusAdmin
                                      ? "Wait Superadmin"
                                      : statusDone
                                          ? "Done"
                                          : "Canceled";

                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 5, bottom: 5),
                            child: ActivityCard(
                              icon: Icons.abc,
                              title: izin.users?.name,
                              subtitle: subtitel,
                              color: Colors.blueAccent,
                              colorbg: Colors.white,
                              colorTitle: Colors.black,
                              onClick: () {
                                // context
                                //     .read<IzinCubit>()
                                //     .clickMenu(izin.status, context);
                              },
                              date: convertDateFormat(izin.startDate),
                              progress: status,
                              reason: izin.reason,
                              popupMenuButton: PopupMenuButton(
                                surfaceTintColor: Colors.white,
                                color: Colors.white,
                                offset: const Offset(
                                    -20, 35), // SET THE (X,Y) POSITION
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.grey,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                onSelected: (value) {
                                  if (value == 'Detail') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailActivity(
                                            status: status,
                                            actionMode: ActionMode.view,
                                            id: izin.id.toString(),
                                            name: izin.users!.name,
                                            startDate: izin.startDate,
                                            endDate: izin.endDate,
                                            startTime: izin.startTime,
                                            endTime: izin.endTime,
                                            reason: izin.reason,
                                            description: izin.description),
                                      ),
                                    );
                                  } else {
                                    // donlod pdf
                                    // print("izin Id");
                                    // print(izin.id);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DownloadPage(
                                          name: "${izin.users?.name}.pdf",
                                          path:
                                              "https://izin.hanatekindo.com/pdf-izin/${izin.id}",
                                        ),
                                      ),
                                    );
                                  }
                                },
                                itemBuilder: (context) {
                                  return [
                                    const PopupMenuItem(
                                      value: 'Detail',
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.remove_red_eye,
                                            // color: Color.fromARGB(
                                            //     255, 67, 128, 252),
                                          ),
                                          Text(
                                            ' Detail',
                                            // style: TextStyle(
                                            //   color: Color.fromARGB(
                                            //       255, 67, 128, 252),
                                            // ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 'pdf',
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.picture_as_pdf,
                                            // color: Color.fromARGB(
                                            //     255, 100, 41, 229),
                                          ),
                                          Text(
                                            ' PDF',
                                            // style: TextStyle(
                                            //   color: Color.fromARGB(
                                            //       255, 100, 41, 229),
                                            // ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ];
                                },
                              ),
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
      floatingActionButton:
          BlocBuilder<IzinCubit, IzinState>(builder: (context, state) {
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
                                    DropdownButtonFormField(
                                      borderRadius: BorderRadius.circular(10),
                                      focusNode: _focusNodes[0],
                                      decoration:
                                          ConstantStyle.inputDecorationDefault(
                                              "Pilih Status"),
                                      items: state.listDataIzin.map(
                                        (String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (String? newValue) {
                                        state.selectedValue = newValue!;
                                      },
                                    ),
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
                                    Navigator.pop(context); // Tutup BottomSheet
                                    izinCubit.selectStatus(
                                        state.selectedValue, context);
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
      }),
    );
  }
}