import 'package:equatable/equatable.dart';

import '../../model/user.dart';

class ProfileState extends Equatable {
  final User user;
  final User person;
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;

  ProfileState({
    User? user,
    User? person,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
  })  : user = user ?? User(),
        person = person ?? User();

  ProfileState copyWith({
    User? user,
    User? person,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return ProfileState(
      user: user ?? this.user,
      person: person ?? this.person,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [user, person, isLoading, isSuccess, errorMessage];
}
