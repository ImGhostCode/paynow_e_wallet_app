import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/card_params.dart';
import 'package:paynow_e_wallet_app/core/utils/usecases/usecase.dart';
import 'package:paynow_e_wallet_app/features/card/business/repositories/card_repository.dart';

class UpdateCardUsecase extends UseCase<void, UpdateCardParams> {
  final CardRepository repository;

  UpdateCardUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateCardParams params) async {
    final result = await repository.updateCard(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
