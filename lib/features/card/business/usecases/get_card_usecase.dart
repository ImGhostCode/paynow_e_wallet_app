import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/utils/usecases/usecase.dart';
import 'package:paynow_e_wallet_app/features/card/business/entities/card_entity.dart';
import 'package:paynow_e_wallet_app/features/card/business/repositories/card_repository.dart';

class GetCardUsecase extends UseCase<List<CardEntity>, String> {
  final CardRepository repository;

  GetCardUsecase(this.repository);

  @override
  Future<Either<Failure, List<CardEntity>>> call(String params) async {
    final result = await repository.getCard(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
