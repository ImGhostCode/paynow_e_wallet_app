import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paynow_e_wallet_app/core/network/error/exceptions.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/auth_params.dart';
import 'package:paynow_e_wallet_app/features/auth/business/repositories/auth_repository.dart';
import 'package:paynow_e_wallet_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(
    this.authRemoteDataSource,
  );

  @override
  Future<Either<Failure, User?>> signUp(SignUpParams params) async {
    try {
      final result = await authRemoteDataSource.signUp(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }
}
