import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../model/user.dart';
import '../../router/app_routes.dart';
import '../../utils/helper/helper.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  Future<void> initData(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? user = await Helper().getDataUser();
      print(user);

      if (user != null) {
        emit(state.copyWith(
            user: User.fromJson(jsonDecode(user)),
            isLoading: false,
            isSuccess: true));
      } else {
        emit(state.copyWith(isLoading: false, isSuccess: false));
      }
      // Simulasikan pengambilan data user dengan delay
      // await Future.delayed(const Duration(seconds: 2));
      // // Misalkan data user diperoleh di sini
      // final user = User(
      //   username: username,
      //   email: 'user@example.com',
      //   name: 'John Doe',
      // );
      // emit(state.copyWith(user: user, isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load data'));
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await Helper().deleteDataUser();
      await Helper().deleteToken();
      await Helper().deleteInitialLocation();
      if (context.mounted) {
        context.go(Routes.HOME);
      } // Sesuaikan dengan route login
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to log out'));
    }
  }
}
