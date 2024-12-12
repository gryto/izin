import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../router/app_routes.dart';
import '../../services/service.dart';
import '../../utils/constants/constantVar.dart';
import '../../utils/helper/helper.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  Future<void> login(
      BuildContext context, String username, String password) async {
    emit(state.copyWith(isLoading: true));
    // Simulasi login API call
    Map body = {
      "username": username,
      "password": password,
    };
    var response = await Request.req(
        path: PathUrl.login,
        params: null,
        body: body,
        token: null,
        method: 'post');
    var result = json.decode(response!.body);

    // await Future.delayed(const Duration(seconds: 2));
    // final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    // final SharedPreferences prefs = await prefs0;
    // response.statusCode == 200
    if (response.statusCode == 200) {
      Helper().saveToken(result['token']);
      Helper().saveDataUser(jsonEncode(result['data']));
      Helper().saveInitialLocation("/${Routes.MAINPAGE}");

      emit(state.copyWith(isLoading: false, isSuccess: true));
      if (context.mounted) {
        context.go("/${Routes.MAINPAGE}");
      }
    } else {
      emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Login gagal. Username atau password salah.'));
      emit(state.copyWith(errorMessage: ''));
    }
  }
}
