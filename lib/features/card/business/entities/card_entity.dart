import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';

part 'card_entity.g.dart';

@JsonSerializable()
class CardEntity {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "cardHolderName")
  final String cardHolderName;
  @JsonKey(name: "cardNumber")
  final String cardNumber;
  @JsonKey(name: "cvv")
  final int cvv;
  @JsonKey(
      toJson: Helper.toJsonTimestamp,
      fromJson: Helper.fromJsonTimestamp,
      name: "expiryDate")
  final DateTime expiryDate;
  @JsonKey(name: "ownerId")
  final String ownerId;
  @JsonKey(name: "balance")
  final double balance;
  @JsonKey(name: "defaultCard")
  final bool defaultCard;

  CardEntity({
    this.id,
    required this.cardHolderName,
    required this.cardNumber,
    required this.cvv,
    required this.expiryDate,
    required this.ownerId,
    required this.balance,
    required this.defaultCard,
  });

  CardEntity copyWith({
    String? id,
    String? cardHolderName,
    String? cardNumber,
    int? cvv,
    DateTime? expiryDate,
    String? ownerId,
    double? balance,
    bool? defaultCard,
  }) =>
      CardEntity(
        id: id ?? this.id,
        cardHolderName: cardHolderName ?? this.cardHolderName,
        cardNumber: cardNumber ?? this.cardNumber,
        cvv: cvv ?? this.cvv,
        expiryDate: expiryDate ?? this.expiryDate,
        ownerId: ownerId ?? this.ownerId,
        balance: balance ?? this.balance,
        defaultCard: defaultCard ?? this.defaultCard,
      );

  factory CardEntity.fromJson(Map<String, dynamic> json) =>
      _$CardEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CardEntityToJson(this);

  factory CardEntity.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CardEntity.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    return toJson()..remove('id');
  }
}
