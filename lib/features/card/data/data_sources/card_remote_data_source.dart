import 'package:paynow_e_wallet_app/core/params/card_params.dart';
import 'package:paynow_e_wallet_app/features/card/data/models/card_model.dart';

abstract class CardRemoteDataSource {
  Future<List<CardModel>> getCard(String userId);
  Future<CardModel> addCard(AddCardParams params);
  Future<void> updateCard(UpdateCardParams params);
  Future<void> setDefault(SetDefaultCardParams params);
  Future<void> deleteCard(String id);
}
