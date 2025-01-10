import 'package:firebase_auth/firebase_auth.dart';
import 'package:paynow_e_wallet_app/core/params/auth_params.dart';
import 'package:paynow_e_wallet_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<User?> signUp(SignUpParams params);
  Future<User?> login(LoginParams params);
  Future<UserModel?> getUser(String id);
}
