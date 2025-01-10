import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paynow_e_wallet_app/core/network/error/exceptions.dart';
import 'package:paynow_e_wallet_app/core/params/auth_params.dart';
import 'package:paynow_e_wallet_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:paynow_e_wallet_app/features/auth/data/models/user_model.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSourceImpl(this._firebaseAuth, this._firestore);

  @override
  Future<User?> signUp(SignUpParams params) async {
    try {
      UserCredential result =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: params.email, password: params.password);
      // Create a new user in Firestore
      await _firestore.collection('users').doc(result.user?.uid).set(
            UserModel(
                    avatar: '',
                    email: params.email,
                    fullName: result.user?.displayName ?? '',
                    phoneNumber: '',
                    balance: 0,
                    cards: [],
                    createdAt: DateTime.now())
                .toJson(),
          );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<User?> login(LoginParams params) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
          email: params.email, password: params.password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<UserModel?> getUser(String id) async {
    try {
      final result = await _firestore.collection('users').doc(id).get();
      return UserModel.fromJson(result.data()!);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}
