import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/card_params.dart';
import 'package:paynow_e_wallet_app/features/card/business/entities/card_entity.dart';

abstract class CardRepository {
  Future<Either<Failure, List<CardEntity>>> getCard(String userId);
  Future<Either<Failure, CardEntity>> addCard(AddCardParams params);
  Future<Either<Failure, void>> updateCard(UpdateCardParams params);
  Future<Either<Failure, void>> setDefault(SetDefaultCardParams params);
  Future<Either<Failure, void>> deleteCard(String id);
}
