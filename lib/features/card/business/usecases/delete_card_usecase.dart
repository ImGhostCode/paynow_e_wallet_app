import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/utils/usecases/usecase.dart';
import 'package:paynow_e_wallet_app/features/card/business/repositories/card_repository.dart';

class DeleteCardUsecase extends UseCase<void, String> {
  final CardRepository repository;

  DeleteCardUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    final result = await repository.deleteCard(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
