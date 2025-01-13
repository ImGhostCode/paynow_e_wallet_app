import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/profile_params.dart';
import 'package:paynow_e_wallet_app/core/utils/usecases/usecase.dart';
import 'package:paynow_e_wallet_app/features/auth/business/repositories/auth_repository.dart';

class UpdateUserUsecase extends UseCase<void, UpdateUserParams> {
  final AuthRepository repository;

  UpdateUserUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateUserParams params) async {
    final result = await repository.updateUser(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
