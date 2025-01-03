import 'package:firebase_auth/firebase_auth.dart';
import 'package:paynow_e_wallet_app/core/utils/injections.dart';
import 'package:paynow_e_wallet_app/features/auth/business/repositories/auth_repository.dart';
import 'package:paynow_e_wallet_app/features/auth/business/usecases/signup_usecase.dart';
import 'package:paynow_e_wallet_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:paynow_e_wallet_app/features/auth/data/data_sources/remote/auth_remote_data_source_impl.dart';
import 'package:paynow_e_wallet_app/features/auth/data/repositories/auth_repository_impl.dart';

void initAuthInjections() {
  sl.registerSingleton<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(FirebaseAuth.instance));
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));
  sl.registerSingleton<SignUpUsecase>(SignUpUsecase(sl()));
}
