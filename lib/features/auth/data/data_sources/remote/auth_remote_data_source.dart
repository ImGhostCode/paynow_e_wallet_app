import 'package:firebase_auth/firebase_auth.dart';
import 'package:paynow_e_wallet_app/core/params/auth_params.dart';

abstract class AuthRemoteDataSource {
  Future<User?> signUp(SignUpParams params);
}
