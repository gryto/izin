import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hma2/screens/atk/dashboard.dart';
import '../../model/dashboardAtk.dart';
import '../../model/etalaseAtk.dart';
import '../../model/menuIzin.dart';
import '../../model/user.dart';
import '../../screens/atk/etalase/etalase.dart';
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
          screen: const EtalasePage()),
      MenuIzin(
          title: "Laporan",
          icon: const Icon(Icons.book),
          screen: const DashboardAtk()),
    ]));
  }

  Future<void> initDataEtalase(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? user = await Helper().getDataUser();
      String? token = await Helper().getToken();

      if (user != null && token != null) {
        emit(state.copyWith(user: User.fromJson(jsonDecode(user))));
        var response = await Request.req(
            path: PathUrl.atkPermintaanEtalase,
            params: null,
            body: null,
            token: token,
            method: 'get');
        var result = json.decode(response!.body);

        if (response.statusCode == 200) {
          var data = (result['data']['barang']['data'] as List)
              .map((item) => Data2.fromJson(item))
              .toList()
              .cast<Data2>();
          emit(
            state.copyWith(
              etalaseAtkRequest: data,
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

  void navigateTo(String menu, int i) {
    emit(state.copyWith(currentScreen: menu, indexMenu: i));
  }

  void loadEtalase(List<Data2> items) {
    emit(state.copyWith(
      etalaseAtkRequest: items,
      filteredEtalase: items, // Awalnya semua item ditampilkan
    ));
  }

  void filterEtalase(String query) {
    List<Data2> filteredList = state.etalaseAtkRequest
        .where((item) =>
            item.namaBarang?.toLowerCase().contains(query.toLowerCase()) ??
            false)
        .toList();

    print(filteredList);

    emit(state.copyWith(
      searchQuery: query,
      filteredEtalase: filteredList,
    ));
  }

  void setJumlah(String value) {
    state.jumlahController.text = value;
    emit(state.copyWith());
  }

  void tambahJumlah() {
    int current = int.tryParse(state.jumlahController.text) ?? 0;
    state.jumlahController.text = (current + 1).toString();
    emit(state.copyWith());
  }

  void kurangJumlah() {
    int current = int.tryParse(state.jumlahController.text) ?? 0;
    if (current > 0) {
      state.jumlahController.text = (current - 1).toString();
      emit(state.copyWith());
    }
  }

  @override
  Future<void> close() {
    state.jumlahController.dispose();
    return super.close();
  }
}
