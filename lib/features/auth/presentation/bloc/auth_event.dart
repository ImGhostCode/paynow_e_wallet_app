import 'package:equatable/equatable.dart';
import 'package:paynow_e_wallet_app/core/params/profile_params.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoadingEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignUpEvent(
      {required this.name, required this.email, required this.password});
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});
}

class LogoutEvent extends AuthEvent {}

class GetUserEvent extends AuthEvent {
  final String id;

  const GetUserEvent({required this.id});
}

class UpdateUserEvent extends AuthEvent {
  final UpdateUserParams params;

  const UpdateUserEvent({required this.params});
}
