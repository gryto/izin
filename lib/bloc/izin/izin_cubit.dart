import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hma2/model/submissionAll.dart';
import 'package:hma2/screens/izin/submission/submission.dart';
import 'package:intl/intl.dart';
import '../../model/dashboardIzin.dart';
import '../../model/izinAll.dart';
import '../../model/menuIzin.dart';
import '../../model/report.dart';
import '../../model/user.dart';
import '../../router/app_routes.dart';
import '../../screens/components/showDialog.dart';
import '../../screens/izin/activity/aktivitas.dart';
import '../../screens/izin/dashboard.dart';
import '../../screens/izin/report/report.dart';
import '../../screens/izin/user/user.dart';
import '../../services/service.dart';
import '../../utils/constants/constantVar.dart';
import '../../utils/helper/helper.dart';
import 'izin_state.dart';

class IzinCubit extends Cubit<IzinState> {
  IzinCubit() : super(IzinState());

  void clickMenu(String title, BuildContext context) {
    switch (title) {
      case 'DAR':
        context.go("/${Routes.MAINPAGE}/${Routes.DAR}");
        break;
      case 'Form Izin':
        context.go("/${Routes.MAINPAGE}/${Routes.IZIN}");
        break;
      default:
      // cShowDialog(
      //     context: context, title: "Warning", message: 'Under Maintenance');
    }
    print(title);
  }

  Future<void> initData(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? user = await Helper().getDataUser();
      String? token = await Helper().getToken();
      print(user);

      if (user != null && token != null) {
        emit(state.copyWith(user: User.fromJson(jsonDecode(user))));
        var response = await Request.req(
            path: "${PathUrl.dashboardIzin}${state.user.username}",
            params: null,
            body: null,
            token: token,
            method: 'get');
        var result = json.decode(response!.body);
        if (response.statusCode == 200) {
          // DashboardIzinAll.fromJson(result['data']);
          emit(
            state.copyWith(
              dashboardIzin: DashboardIzinAll.fromJson(result['data']),
            ),
          );

          print(state.dashboardIzin);
        } else {
          cShowDialog(
              context: context, title: "Warning", message: result['success']);
        }
      } else {
        emit(state.copyWith(isLoading: false, isSuccess: false));
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load data'));
    }
  }

  // Future<void> initMenu() async {
  //   emit(state.copyWith(currentScreen: 'Dashboard', listMenu: []));

  //   try {
  //     String? user = await Helper().getDataUser();
  //     print("listmenuid");
  //     print(user);

  //     if (user != null) {
  //       // Decode the user information and extract the userId
  //       var decodedUser = jsonDecode(user);
  //       String role =
  //           decodedUser['role']; // Assuming 'id' is part of the user model
  //       print("Userid");
  //       print(role);

  //       List<MenuIzin> menuItems = [
  //         MenuIzin(
  //           title: "Dashboard",
  //           icon: const Icon(Icons.dashboard),
  //           screen: const DashboardIzin(),
  //         ),
  //         MenuIzin(
  //           title: "Pengajuan Izin",
  //           icon: const Icon(Icons.calendar_month),
  //           screen: const SubmissionPage(),
  //         ),
  //         MenuIzin(
  //           title: "Izin Saya",
  //           icon: const Icon(Icons.timeline),
  //           screen: const AktivitasIzin(),
  //         ),
  //         MenuIzin(
  //           title: "Laporan Pengajuan Izin",
  //           icon: const Icon(Icons.note),
  //           screen: const ReportPage(),
  //         ),
  //         MenuIzin(
  //           title: "User",
  //           icon: const Icon(Icons.man),
  //           screen: const UserIzinPage(),
  //         )
  //       ];

  //       // Adjust the menu based on userId
  //       if (role == "1") {
  //         // Show all menus for role == 1
  //         menuItems = menuItems
  //             .where((menu) =>
  //                 menu.title == "Dashboard" ||
  //                 menu.title == "Pengajuan Izin" ||
  //                 menu.title == "Izin Saya" ||
  //                 menu.title == "Laporan Pengajuan Izin" ||
  //                 menu.title == "User")
  //             .toList();
  //       } else if (role == "2") {
  //         // Hide "User" menu for role == 2
  //         menuItems = menuItems
  //             .where((menu) =>
  //                 menu.title == "Dashboard" ||
  //                 menu.title == "Pengajuan Izin" ||
  //                 menu.title == "Izin Saya" ||
  //                 menu.title == "Laporan Pengajuan Izin")
  //             .toList();

  //         // menuItems.removeWhere((menu) => menu.title == "User");
  //       } else if (role == "3") {
  //         // Only show Dashboard and "Izin Saya" for role == 3
  //         menuItems = menuItems
  //             .where((menu) =>
  //                 menu.title == "Dashboard" ||
  //                 menu.title == "Pengajuan Izin" ||
  //                 menu.title == "Izin Saya")
  //             .toList();
  //         // menuItems.removeWhere((menu) => menu.title == "User" &&  menu.title == "Laporan Pengajuan Izin" );
  //       } else {
  //         menuItems = menuItems
  //             .where((menu) =>
  //                 menu.title == "Dashboard" || menu.title == "Izin Saya")
  //             .toList();
  //       }

  //       emit(state.copyWith(listMenu: menuItems));
  //     }
  //   } catch (e) {
  //     // Handle error if any
  //     emit(state.copyWith(
  //         isLoading: false, errorMessage: 'Failed to load menu'));
  //   }
  // }

  Future<void> initMenu() async {
    emit(state.copyWith(currentScreen: 'Dashboard', listMenu: []));

    try {
      String? user = await Helper().getDataUser();
      if (user != null) {
        final role = jsonDecode(user)['role'];

        final menuItems = [
          MenuIzin(
            title: "Dashboard",
            icon: const Icon(Icons.dashboard),
            screen: const DashboardIzin(),
          ),
          MenuIzin(
            title: "Pengajuan Izin",
            icon: const Icon(Icons.calendar_month),
            screen: const SubmissionPage(),
          ),
          MenuIzin(
            title: "Izin Saya",
            icon: const Icon(Icons.timeline),
            screen: const AktivitasIzin(),
          ),
          MenuIzin(
            title: "Laporan Pengajuan Izin",
            icon: const Icon(Icons.note),
            screen: const ReportPage(),
          ),
          MenuIzin(
            title: "User",
            icon: const Icon(Icons.man),
            screen: const UserIzinPage(),
          ),
        ];

        final filteredMenu = menuItems.where((menu) {
          switch (role) {
            case "1":
              return true; // Show all menus
            case "2":
              return menu.title != "User"; // Hide "User"
            case "3":
              return menu.title != "User" &&
                  menu.title != "Laporan Pengajuan Izin"; // Show limited menus
            default:
              return menu.title == "Dashboard" || menu.title == "Izin Saya";
          }
        }).toList();

        emit(state.copyWith(listMenu: filteredMenu));
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load menu'));
    }
  }

  Future<void> initIzinData(BuildContext context) async {
    emit(state.copyWith(isLoading: true));

    try {
      String? user = await Helper().getDataUser();
      String? token = await Helper().getToken();
      print(user);

      if (user != null && token != null) {
        emit(state.copyWith(user: User.fromJson(jsonDecode(user))));
        var response = await Request.req(
            path: "${PathUrl.izinAll}${state.user.username}/semua",
            params: null,
            body: null,
            token: token,
            method: 'get');
        var result = json.decode(response!.body);
        print(result);
        print("${PathUrl.izinAll}${state.user.username}/semua");
        print(response.statusCode);

        if (response.statusCode == 200) {
          var izinData = (result['data'] as List)
              .map((item) => IzinAll.fromJson(item))
              .toList()
              .cast<IzinAll>();
          print("Parsed izinAll: $izinData");

          if (state.selectedValue == 'Semua' || state.selectedValue == "") {
            emit(state.copyWith(isLoading: false, izinAll: izinData));
          } else {
            emit(state.copyWith(
                izinAll: izinData
                    .where((izinAll) =>
                        _matchesStatus(izinAll, state.selectedValue))
                    .toList()));
          }
        } else {
          cShowDialog(
              context: context, title: "Warning", message: result['success']);
        }
      } else {
        emit(state.copyWith(isLoading: false, isSuccess: false));
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load data'));
    }
  }

  Future<void> initUserIzinData(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? user = await Helper().getDataUser();
      String? token = await Helper().getToken();
      print(user);

      if (user != null && token != null) {
        emit(state.copyWith(user: User.fromJson(jsonDecode(user))));
        var response = await Request.req(
            path: "${PathUrl.user}${state.user.id}",
            params: null,
            body: null,
            token: token,
            method: 'get');
        var result = json.decode(response!.body);
        print("pathuser");
        print("${PathUrl.user}${state.user.id}");
        if (response.statusCode == 200) {
          // DashboardIzinAll.fromJson(result['data']);
          emit(
            state.copyWith(
              userIzin: User.fromJson(result['data']),
            ),
          );
          print("uyserizin");
          print(state.userIzin);
        } else {
          cShowDialog(
              context: context, title: "Warning", message: result['success']);
        }
      } else {
        emit(state.copyWith(isLoading: false, isSuccess: false));
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load data'));
    }
  }

  void resetForm() {
    // state.kodepaketTextEditingController.clear();
    // state.judulTextEditingController.clear();
    // state.tahunTextEditingController.clear();
    // state.keteranganTextEditingController.clear();
    state.ctrlName.clear();
    state.ctrlStartDate.clear();
    state.ctrlEndDate.clear();
    state.ctrlStartTime.clear();
    state.ctrlEndTime.clear();
    state.ctrlReason.clear();
    state.ctrlDescription.clear();
  }

  Future<void> initAddIzinData(BuildContext context, String starDate,
      String endDate, startTime, endTime, reason, description, username) async {
    String convertDateFormat(String date) {
      // Parse the input date string (dd/MM/yyyy)
      DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);

      // Format the DateTime object into the new format (yyyy-MM-dd)
      String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

      return formattedDate;
    }

    emit(state.copyWith(isLoading: true));

    Map body = {
      "start_date": convertDateFormat(starDate),
      "end_date": convertDateFormat(endDate),
      "start_time": startTime,
      "end_time": endTime,
      "alasan": reason,
      "deskripsi": description,
      "username": username,
    };
    print("body");
    print(body);

    try {
      String? user = await Helper().getDataUser();
      String? token = await Helper().getToken();
      print(user);

      if (user != null && token != null) {
        emit(state.copyWith(user: User.fromJson(jsonDecode(user))));
        var response = await Request.req(
            path: PathUrl.addIzin,
            params: null,
            body: body,
            token: token,
            method: 'post');
        var result = json.decode(response!.body);
        print("pathuseradd");
        print(PathUrl.addIzin);
        print("resukt");
        print(result);
        print(response.statusCode);
        print(result);
        if (response.statusCode == 200 && result['success'] == true) {
          // emit(state.copyWith(isUpdateSuccess: true));
          // emit(state.copyWith(isUpdateSuccess: false));
          emit(state.copyWith(
              message: 'Create Izin Berhasil',
              titleMessage: 'Success',
              typeMessage: 'success'));
          emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
          resetForm();
          await initIzinData(
              context); // Call initIzinData to update izinAll data
        } else {
          // emit(state.copyWith(errorMessage: "Gagal Update Data"));
          // emit(state.copyWith(errorMessage: ""));
          emit(state.copyWith(
              message: 'Gagal Create Izin',
              titleMessage: 'Failed',
              typeMessage: 'error'));
          emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
        }
      }
    } catch (e) {
      // emit(state.copyWith(
      //     isLoading: false, errorMessage: 'Failed to load data'));
      emit(state.copyWith(
          message: e.toString(), titleMessage: 'Failed', typeMessage: 'error'));
      emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
    }
  }

  Future<void> refreshIzinData(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? user = await Helper().getDataUser();
      String? token = await Helper().getToken();
      print(user);

      if (user != null && token != null) {
        emit(state.copyWith(user: User.fromJson(jsonDecode(user))));
        var response = await Request.req(
            path: "${PathUrl.izinAll}${state.user.username}/semua",
            params: null,
            body: null,
            token: token,
            method: 'get');
        var result = json.decode(response!.body);
        print("${PathUrl.izinAll}${state.user.username}/semua");
        if (response.statusCode == 200) {
          print('Data refresh successful');
          await initIzinData(
              context); // Call initIzinData to update izinAll data

          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AktivitasIzin()),
            );
          }
        } else {
          emit(state.copyWith(
              isLoading: false, errorMessage: 'Gagal Get Data All Permission'));
          emit(state.copyWith(errorMessage: ''));
        }
      } else {
        emit(state.copyWith(isLoading: false, isSuccess: false));
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load data'));
    }
  }

  Future<void> refreshSubmissionData(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? user = await Helper().getDataUser();
      String? token = await Helper().getToken();
      print(user);

      if (user != null && token != null) {
        emit(state.copyWith(user: User.fromJson(jsonDecode(user))));
        var response = await Request.req(
            path: PathUrl.submissionAll,
            params: null,
            body: null,
            token: token,
            method: 'get');
        var result = json.decode(response!.body);

        print(PathUrl.submissionAll);

        if (response.statusCode == 200) {
          print('Data refresh successful');
          await initSubmissionData(
              context); // Call initIzinData to update izinAll data

          // Navigate to another screen if the context is still mounted
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AktivitasIzin(),
              ),
            );
          }
        } else {
          emit(state.copyWith(
              isLoading: false, errorMessage: 'Gagal Get Data All Permission'));
          emit(state.copyWith(errorMessage: ''));
        }
      } else {
        emit(state.copyWith(isLoading: false, isSuccess: false));
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load data'));
    }
  }

  Future<void> initCancelIzinData(
      BuildContext context,
      String id,
      String starDate,
      String endDate,
      startTime,
      endTime,
      reason,
      description,
      username) async {
    emit(state.copyWith(isLoading: true));

    Map body = {
      "id": id,
      "start_date": starDate,
      "end_date": endDate,
      "start_time": startTime,
      "end_time": endTime,
      "alasan": reason,
      "deskripsi": description,
      "username": username,
      "status": "cancel",
    };
    print("bodycancel");
    print(body);

    try {
      String? user = await Helper().getDataUser();
      String? token = await Helper().getToken();
      print(user);

      if (user != null && token != null) {
        emit(state.copyWith(user: User.fromJson(jsonDecode(user))));
        var response = await Request.req(
            path: PathUrl.updateIzin,
            params: null,
            body: body,
            token: token,
            method: 'post');
        var result = json.decode(response!.body);
        print("pathusercancel");
        print(PathUrl.addIzin);
        print("result");
        print(result);
        print(response.statusCode);
        print(result);

        if (response.statusCode == 200 && result['success'] == true) {
          emit(state.copyWith(
              message: 'Cancel Izin Berhasil',
              titleMessage: 'Success',
              typeMessage: 'success'));
          emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
          resetForm();
          await initIzinData(
              context); // Call initIzinData to update izinAll data
        } else {
          // emit(state.copyWith(errorMessage: "Gagal Update Data"));
          // emit(state.copyWith(errorMessage: ""));
          emit(state.copyWith(
              message: 'Gagal Create Izin',
              titleMessage: 'Failed',
              typeMessage: 'error'));
          emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
        }
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load data'));
    }
  }

  Future<void> initUpdateIzinData(
      BuildContext context,
      String id,
      String starDate,
      String endDate,
      startTime,
      endTime,
      reason,
      description,
      username) async {
    emit(state.copyWith(isLoading: true));

    String convertDateFormat(String date) {
      // Parse the input date string (dd/MM/yyyy)
      DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);

      // Format the DateTime object into the new format (yyyy-MM-dd)
      String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

      return formattedDate;
    }

    Map body = {
      "id": id,
      "start_date": convertDateFormat(starDate),
      "end_date": convertDateFormat(endDate),
      "start_time": startTime,
      "end_time": endTime,
      "alasan": reason,
      "deskripsi": description,
      "username": username,
      "status": "update",
    };
    print("bodycancel");
    print(body);

    try {
      String? user = await Helper().getDataUser();
      String? token = await Helper().getToken();
      print(user);

      if (user != null && token != null) {
        emit(state.copyWith(user: User.fromJson(jsonDecode(user))));
        var response = await Request.req(
            path: PathUrl.updateIzin,
            params: null,
            body: body,
            token: token,
            method: 'post');
        var result = json.decode(response!.body);
        print("pathuserupdate");
        print(PathUrl.addIzin);
        print("result");
        print(result);
        print(response.statusCode);
        print(result);

        if (response.statusCode == 200 && result['success'] == true) {
          emit(state.copyWith(
              message: 'Update Izin Berhasil',
              titleMessage: 'Success',
              typeMessage: 'success'));
          emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
          resetForm();
          await initIzinData(
              context); // Call initIzinData to update izinAll data
        } else {
          // emit(state.copyWith(errorMessage: "Gagal Update Data"));
          // emit(state.copyWith(errorMessage: ""));
          emit(state.copyWith(
              message: 'Gagal Create Paket',
              titleMessage: 'Failed',
              typeMessage: 'error'));
          emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
        }
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load data'));
    }
  }

  void selectStatus(String value, BuildContext context) {
    emit(state.copyWith(selectedValue: value));
    initIzinData(context);
  }

  void selectSubmissionStatus(String value, BuildContext context) {
    emit(state.copyWith(selectedValue: value));
    initSubmissionData(context);
  }

  // Private helper function for status matching
  bool _matchesStatus(IzinAll izin, String selectedStatus) {
    switch (selectedStatus) {
      case 'Pending':
        return izin.status == "1" &&
            izin.statusAdmin == "1" &&
            izin.statusSuperadmin == "1";
      case 'Disetujui admin':
        return izin.status == "1" &&
            izin.statusAdmin == "2" &&
            izin.statusSuperadmin == "1";
      case 'Disetujui superadmin':
        return izin.status == "1" &&
            izin.statusAdmin == "1" &&
            izin.statusSuperadmin == "2";
      case 'Ditolak admin':
        return izin.status == "2" &&
            izin.statusAdmin == "3" &&
            izin.statusSuperadmin == "2";
      case 'Ditolak superadmin':
        return izin.status == "3" &&
            izin.statusAdmin == "2" &&
            izin.statusSuperadmin == "3";
      case 'Selesai':
        return izin.status == "2" &&
            izin.statusAdmin == "2" &&
            izin.statusSuperadmin == "2";
      case 'Cancel':
        return izin.status == "3" &&
            izin.statusAdmin == "2" &&
            izin.statusSuperadmin == "2";
      default:
        return true; // 'Semua' or any unhandled case returns all results.
    }
  }

  bool _matchesSubmissionStatus(SubmissionAll izin, String selectedStatus) {
    switch (selectedStatus) {
      case 'Pending':
        return izin.status == "1" &&
            izin.statusAdmin == "1" &&
            izin.statusSuperadmin == "1";
      case 'Disetujui admin':
        return izin.status == "1" &&
            izin.statusAdmin == "2" &&
            izin.statusSuperadmin == "1";
      case 'Disetujui superadmin':
        return izin.status == "1" &&
            izin.statusAdmin == "1" &&
            izin.statusSuperadmin == "2";
      case 'Ditolak admin':
        return izin.status == "2" &&
            izin.statusAdmin == "3" &&
            izin.statusSuperadmin == "2";
      case 'Ditolak superadmin':
        return izin.status == "3" &&
            izin.statusAdmin == "2" &&
            izin.statusSuperadmin == "3";
      case 'Selesai':
        return izin.status == "2" &&
            izin.statusAdmin == "2" &&
            izin.statusSuperadmin == "2";
      case 'Cancel':
        return izin.status == "3" &&
            izin.statusAdmin == "2" &&
            izin.statusSuperadmin == "2";
      default:
        return true; // 'Semua' or any unhandled case returns all results.
    }
  }

  void navigateTo(String menu, int i) {
    emit(state.copyWith(currentScreen: menu, indexMenu: i));
  }

  void updateStatus(int? id, String newStatus) {
    print(newStatus);
  }

  Future<String?> getUserRole() async {
    // final String? userData = prefs.getString('user');
    String? user = await Helper().getDataUser();
    // if (user != null) {
      final Map<String, dynamic> userMap = jsonDecode(user!);
      emit(state.copyWith(userRole: userMap['role']));
      // userRole = userMap['role']; // Ambil nilai role
    // }
    // return null;
  }

  Future<void> initSubmissionData(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? user = await Helper().getDataUser();
      String? token = await Helper().getToken();
      print("usetdata");
      print(user);

      if (user != null && token != null) {
        emit(state.copyWith(user: User.fromJson(jsonDecode(user))));
        var response = await Request.req(
            path: PathUrl.submissionAll,
            params: null,
            body: null,
            token: token,
            method: 'get');
        var result = json.decode(response!.body);

        print("submission");
        print(result);
        print(PathUrl.submissionAll);
        print(response.statusCode);

        if (response.statusCode == 200) {
          var submissionData = (result['data'] as List)
              .map((item) => SubmissionAll.fromJson(item))
              .toList()
              .cast<SubmissionAll>();
          print("Parsed izinAll: $submissionData");

          if (state.selectedValue == 'Semua' || state.selectedValue == "") {
            emit(state.copyWith(
                isLoading: false, submissionAll: submissionData));
          } else {
            emit(state.copyWith(
                submissionAll: submissionData
                    .where((submissionAll) => _matchesSubmissionStatus(
                        submissionAll, state.selectedValue))
                    .toList()));
          }
        } else {
          cShowDialog(
              context: context, title: "Warning", message: result['success']);
        }
      } else {
        emit(state.copyWith(isLoading: false, isSuccess: false));
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load data'));
    }
  }

  Future<void> initUpdateSubmissionData(
      BuildContext context,
      String id,
      String starDate,
      String endDate,
      startTime,
      endTime,
      reason,
      description,
      username) async {
    emit(state.copyWith(isLoading: true));

    Map body = {
      "id": id,
      "start_date": starDate,
      "end_date": endDate,
      "start_time": startTime,
      "end_time": endTime,
      "alasan": reason,
      "deskripsi": description,
      "username": username,
      "status": "approve",
    };
    print("bodyupdatesubmission");
    print(body);

    try {
      print("sblm try");
      String? user = await Helper().getDataUser();
      String? token = await Helper().getToken();
      print(user);
      print("ssudahtry");

      if (user != null && token != null) {
        emit(state.copyWith(user: User.fromJson(jsonDecode(user))));
        var response = await Request.req(
            path: PathUrl.updateSubmission,
            params: null,
            body: body,
            token: token,
            method: 'post');

        var result = json.decode(response!.body);
        print("path submissionupdate");
        print(PathUrl.updateSubmission);
        print("result");
        print(result);
        print(response.statusCode);
        print(result);

        if (response.statusCode == 200 && result['success'] == true) {
          emit(state.copyWith(isUpdateSuccess: true));
          emit(state.copyWith(isUpdateSuccess: false));
        } else {
          emit(state.copyWith(errorMessage: "Gagal Update Data"));
          emit(state.copyWith(errorMessage: ""));
        }
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load data'));
    }
  }

  Future<void> initUsetIzinData(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? user = await Helper().getDataUser();
      String? token = await Helper().getToken();
      print(user);

      if (user != null && token != null) {
        emit(state.copyWith(user: User.fromJson(jsonDecode(user))));
        var response = await Request.req(
            path: PathUrl.user,
            params: null,
            body: null,
            token: token,
            method: 'get');
        var result = json.decode(response!.body);

        print("userizinlist");
        print(result);
        print(PathUrl.user);
        print(response.statusCode);

        if (response.statusCode == 200) {
          var userList = (result['data'] as List)
              .map((item) => User.fromJson(item))
              .toList()
              .cast<User>();
          print("Parsed izinAll: $userList");
          var userNameList = userList.map((user) => user.name ?? '').toList();

          print(userNameList);

          if (state.selectedValue == 'Semua' || state.selectedValue == "") {
            emit(state.copyWith(
              isLoading: false,
              userIzinList: userList,
              listUser: userNameList,
            ));
          } else {
            // Filter user list based on selectedValue (you may need to adjust the comparison)
            emit(
              state.copyWith(
                isLoading: false,
                userIzinList: userList.where((userIzin) {
                  // Filter condition for selectedValue
                  return userIzin.name
                          ?.toLowerCase()
                          .contains(state.selectedValue.toLowerCase()) ??
                      false;
                }).toList(),
              ),
            );
          }

          print("listusernama");

          print(state.listUser);
        } else {
          cShowDialog(
              context: context, title: "Warning", message: result['success']);
        }
      } else {
        emit(state.copyWith(isLoading: false, isSuccess: false));
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load data'));
    }
  }

  Future<void> initGenerateData(
      BuildContext context, startDate, endDate, username) async {
    emit(state.copyWith(isLoading: true));

    String convertDateFormat(String date) {
      // Parse the input date string (dd/MM/yyyy)
      DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);

      // Format the DateTime object into the new format (yyyy-MM-dd)
      String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

      return formattedDate;
    }

    var start_date = convertDateFormat(startDate);
    var end_date = convertDateFormat(endDate);

    try {
      String? user = await Helper().getDataUser();
      String? token = await Helper().getToken();
      print(user);

      if (user != null && token != null) {
        emit(state.copyWith(user: User.fromJson(jsonDecode(user))));
        var response = await Request.req(
            path: "${PathUrl.reportAll}$start_date/$end_date/$username",
            params: null,
            body: null,
            token: token,
            method: 'get');
        print("generatedata");
        print("${PathUrl.reportAll}$start_date/$end_date/$username");
        var result = json.decode(response!.body);
        print(result);
        print(response.statusCode);
        if (response.statusCode == 200) {
          // DashboardIzinAll.fromJson(result['data']);
          emit(
            state.copyWith(
              report: Report.fromJson(result['data']),
            ),
          );

          print(state.report);
        } else {
          cShowDialog(
              context: context, title: "Warning", message: result['success']);
        }
      } else {
        emit(state.copyWith(isLoading: false, isSuccess: false));
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load data'));
    }
  }

  void searchIzin(String keyword) {
    emit(state.copyWith(isLoading: true));

    try {
      // Filter izin berdasarkan keyword
      final results = state.userIzinList.where((izin) {
        final emailLower = izin.email!.toLowerCase();
        final roleLower = izin.role?.toLowerCase();
        final keywordLower = keyword.toLowerCase();
        return emailLower.contains(keywordLower) ||
            roleLower!.contains(keywordLower);
      }).toList();

      emit(state.copyWith(
        isLoading: false,
        searchKeyword: keyword,
        searchResults: results,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Terjadi kesalahan saat mencari data.',
      ));
    }
  }

  Future<void> initAddUserData(BuildContext context, List<int?> arrayId) async {
    emit(state.copyWith(isLoading: true));

    Map body = {
      "data": arrayId,
    };
    print("bodycancel");
    print(body);

    try {
      String? user = await Helper().getDataUser();
      String? token = await Helper().getToken();
      print(user);

      if (user != null && token != null) {
        emit(state.copyWith(user: User.fromJson(jsonDecode(user))));
        var response = await Request.req(
            path: PathUrl.addUser,
            params: null,
            body: body,
            token: token,
            method: 'post');
        var result = json.decode(response!.body);
        print("addUser");
        print(PathUrl.addIzin);
        print("result");
        print(result);
        print(response.statusCode);
        print(result);

        if (response.statusCode == 200 && result['success'] == true) {
          emit(state.copyWith(isUpdateSuccess: true));
          emit(state.copyWith(isUpdateSuccess: false));
        } else {
          emit(state.copyWith(errorMessage: "Gagal Update Data"));
          emit(state.copyWith(errorMessage: ""));
        }
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load data'));
    }
  }

  void toggleSelectionBool() {
    emit(state.copyWith(isSelected: !state.isSelected));
  }

  void toggleSelection(int id) {
    final updatedIds = List<int>.from(state.selectedIds);

    print("list semua id yg dipilih");
    print(updatedIds);

    if (updatedIds.contains(id)) {
      updatedIds.remove(id); // Hapus jika sudah ada
    } else {
      updatedIds.add(id); // Tambahkan jika belum ada
    }
    emit(state.copyWith(selectedIds: updatedIds));
  }

  void toggleSelectAll(List<int> allIds) {
    if (state.selectedIds.length == allIds.length) {
      emit(state.copyWith(
        selectedIds: [], // Batalkan semua
        isSelected: false, // Set semua menjadi tidak terpilih
      ));
    } else {
      emit(state.copyWith(
        selectedIds: List<int>.from(allIds), // Pilih semua
        isSelected: true, // Set semua menjadi terpilih
      ));
    }
  }

  Future<void> refreshIzinDataUser(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? user = await Helper().getDataUser();
      String? token = await Helper().getToken();
      print(user);

      if (user != null && token != null) {
        emit(state.copyWith(user: User.fromJson(jsonDecode(user))));
        var response = await Request.req(
            path: PathUrl.user,
            params: null,
            body: null,
            token: token,
            method: 'get');
        var result = json.decode(response!.body);
        if (response.statusCode == 200) {
          print('Data refresh successful');
          await initUsetIzinData(
              context); // Call initIzinData to update izinAll data
        } else {
          emit(state.copyWith(
              isLoading: false, errorMessage: 'Gagal Get Data All Permission'));
          emit(state.copyWith(errorMessage: ''));
        }
      } else {
        emit(state.copyWith(isLoading: false, isSuccess: false));
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load data'));
    }
  }
}
