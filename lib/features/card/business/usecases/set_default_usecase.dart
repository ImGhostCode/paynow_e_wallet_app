import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/card_params.dart';
import 'package:paynow_e_wallet_app/core/utils/usecases/usecase.dart';
import 'package:paynow_e_wallet_app/features/card/business/repositories/card_repository.dart';

class SetDefaultUsecase extends UseCase<void, SetDefaultCardParams> {
  final CardRepository repository;

  SetDefaultUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(SetDefaultCardParams params) async {
    final result = await repository.setDefault(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
