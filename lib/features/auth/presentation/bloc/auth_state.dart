import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paynow_e_wallet_app/features/auth/business/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  final User? user;
  final UserEntity? userEntity;
  const AuthState({this.user, this.userEntity});

  @override
  List<Object?> get props => [user, userEntity];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  const Authenticated({required super.user});
}

class Unauthenticated extends AuthState {
  final String error;
  const Unauthenticated({required this.error});
}

class IsLoadingUser extends AuthState {
  const IsLoadingUser();
}

class LoadedUser extends AuthState {
  const LoadedUser({required super.userEntity});
}

class ErrorLoadingUser extends AuthState {
  final String error;
  const ErrorLoadingUser({required this.error});
}

class IsUpdatingUser extends AuthState {
  const IsUpdatingUser();
}

class ErrorUpdatingUser extends AuthState {
  final String error;
  const ErrorUpdatingUser({required this.error});
}

class UpdatedUser extends AuthState {
  const UpdatedUser();
}
