import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/auth_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, User?>> signUp(SignUpParams params);
  Future<Either<Failure, User?>> login(LoginParams params);
}
