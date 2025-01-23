import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/card_params.dart';
import 'package:paynow_e_wallet_app/core/utils/usecases/usecase.dart';
import 'package:paynow_e_wallet_app/features/card/business/entities/card_entity.dart';
import 'package:paynow_e_wallet_app/features/card/business/repositories/card_repository.dart';

class AddCardUsecase extends UseCase<CardEntity, AddCardParams> {
  final CardRepository repository;

  AddCardUsecase(this.repository);

  @override
  Future<Either<Failure, CardEntity>> call(AddCardParams params) async {
    final result = await repository.addCard(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
