import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/utils/usecases/usecase.dart';
import 'package:paynow_e_wallet_app/features/auth/business/entities/user_entity.dart';
import 'package:paynow_e_wallet_app/features/auth/business/repositories/auth_repository.dart';

class GetUserUsecase extends UseCase<void, String> {
  final AuthRepository repository;

  GetUserUsecase(this.repository);

  @override
  Future<Either<Failure, UserEntity?>> call(String params) async {
    final result = await repository.getUser(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
