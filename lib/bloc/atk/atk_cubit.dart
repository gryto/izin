import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hma2/screens/atk/dashboard.dart';
import '../../model/dashboardAtk.dart';
import '../../model/menuIzin.dart';
import '../../model/user.dart';
import '../../screens/components/showDialog.dart';
import '../../services/service.dart';
import '../../utils/constants/constantVar.dart';
import '../../utils/helper/helper.dart';
import 'atk_state.dart';

class AtkCubit extends Cubit<AtkState> {
  AtkCubit() : super(AtkState());

  Future<void> initData(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? user = await Helper().getDataUser();
      String? token = await Helper().getToken();

      if (user != null && token != null) {
        emit(state.copyWith(user: User.fromJson(jsonDecode(user))));
        var response = await Request.req(
            path: PathUrl.atkPermintaanDashboard,
            params: null,
            body: null,
            token: token,
            method: 'get');
        var result = json.decode(response!.body);

        if (response.statusCode == 200) {
          var data = DashboardAtkRequest.fromJson(result['data']);

          emit(
            state.copyWith(
              dashboardAtkRequest: data,
            ),
          );
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

  Future<void> initMenu() async {
    emit(state.copyWith(currentScreen: 'Dashboard', listMenu: [
      MenuIzin(
          title: "Dashboard",
          icon: const Icon(Icons.dashboard),
          screen: const DashboardAtk()),
      MenuIzin(
          title: "Request",
          icon: const Icon(Icons.list_alt_rounded),
          screen: const DashboardAtk()),
      MenuIzin(
          title: "Cart",
          icon: const Icon(Icons.shopping_cart),
          screen: const DashboardAtk()),
      MenuIzin(
          title: "Etalase",
          icon: const Icon(Icons.add_card),
          screen: const DashboardAtk()),
      MenuIzin(
          title: "Laporan",
          icon: const Icon(Icons.book),
          screen: const DashboardAtk()),
    ]));
  }

  // Future<void> initMenu() async {
  //   emit(state.copyWith(currentScreen: 'Dashboard', listMenu: []));

  //   try {
  //     String? user = await Helper().getDataUser();
  //     if (user != null) {
  //       final role = jsonDecode(user)['role'];

  //       final menuItems = [
  //         MenuIzin(
  //           title: "Dashboard",
  //           icon: const Icon(Icons.dashboard),
  //           screen: const DashboardAtk(),
  //         ),
  //         MenuIzin(
  //           title: "Request",
  //           icon: const Icon(Icons.dashboard),
  //           screen: const DashboardAtk(),
  //         ),
  //         MenuIzin(
  //           title: "Cart",
  //           icon: const Icon(Icons.dashboard),
  //           screen: const DashboardAtk(),
  //         ),
  //         MenuIzin(
  //           title: "Etalase",
  //           icon: const Icon(Icons.dashboard),
  //           screen: const DashboardAtk(),
  //         ),
  //         MenuIzin(
  //           title: "Laporan",
  //           icon: const Icon(Icons.dashboard),
  //           screen: const DashboardAtk(),
  //         ),
  //         MenuIzin(
  //           title: "Request",
  //           icon: const Icon(Icons.dashboard),
  //           screen: const DashboardAtk(),
  //         ),
  //       ];

  //       final filteredMenu = menuItems.where((menu) {
  //         switch (role) {
  //           case "1":
  //             return true; // Show all menus
  //           case "2":
  //             return menu.title != "Dashboard"; // Hide "User"
  //           case "3":
  //             return menu.title != "Dashboard" &&
  //                 menu.title != "Dashboard"; // Show limited menus
  //           default:
  //             return menu.title == "Dashboard" || menu.title == "Dashboard";
  //         }
  //       }).toList();

  //       emit(state.copyWith(listMenu: filteredMenu));
  //     }
  //   } catch (e) {
  //     emit(state.copyWith(
  //         isLoading: false, errorMessage: 'Failed to load menu'));
  //   }
  // }

  void navigateTo(String menu, int i) {
    emit(state.copyWith(currentScreen: menu, indexMenu: i));
  }
}
