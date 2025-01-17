// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/features/card/business/entities/card_entity.dart';

part 'card_model.g.dart';

@JsonSerializable()
class CardModel extends CardEntity {
  CardModel({
    required super.id,
    required super.cardNumber,
    required super.cardHolderName,
    required super.expiryDate,
    required super.cardType,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CardModelToJson(this);

  // factory CardModel.fromFirestore(DocumentSnapshot doc) {
  //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //   return CardModel.fromJson({'id': doc.id, ...data});
  // }

  // Map<String, dynamic> toFirestore() {
  //   return toJson()..remove('id');
  // }

  CardEntity toEntity() {
    return CardEntity(
        id: id,
        cardNumber: cardNumber,
        cardHolderName: cardHolderName,
        expiryDate: expiryDate,
        cardType: cardType);
  }

  static CardModel fromEntity(CardEntity card) {
    return CardModel(
        id: card.id,
        cardNumber: card.cardNumber,
        cardHolderName: card.cardHolderName,
        expiryDate: card.expiryDate,
        cardType: card.cardType);
  }
}
