// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';
import 'package:paynow_e_wallet_app/features/card/business/entities/card_entity.dart';

part 'card_model.g.dart';

@JsonSerializable()
class CardModel extends CardEntity {
  CardModel({
    required super.id,
    required super.cardNumber,
    required super.cardHolderName,
    required super.expiryDate,
    required super.cvv,
    required super.ownerId,
    required super.balance,
    required super.defaultCard,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CardModelToJson(this);

  factory CardModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CardModel.fromJson({...data, 'id': doc.id});
  }

  @override
  Map<String, dynamic> toFirestore() {
    return toJson()..remove('id');
  }

  CardEntity toEntity() {
    return CardEntity(
        id: id,
        cardNumber: cardNumber,
        cardHolderName: cardHolderName,
        expiryDate: expiryDate,
        cvv: cvv,
        ownerId: ownerId,
        balance: balance,
        defaultCard: defaultCard);
  }

  static CardModel fromEntity(CardEntity card) {
    return CardModel(
        id: card.id,
        cardNumber: card.cardNumber,
        cardHolderName: card.cardHolderName,
        expiryDate: card.expiryDate,
        cvv: card.cvv,
        ownerId: card.ownerId,
        balance: card.balance,
        defaultCard: card.defaultCard);
  }
}
