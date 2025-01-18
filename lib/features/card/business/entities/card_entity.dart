import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

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
  @JsonKey(name: "expiryDate")
  final Timestamp expiryDate;
  @JsonKey(name: "ownerId")
  final String ownerId;

  CardEntity({
    this.id,
    required this.cardHolderName,
    required this.cardNumber,
    required this.cvv,
    required this.expiryDate,
    required this.ownerId,
  });

  CardEntity copyWith({
    String? id,
    String? cardHolderName,
    String? cardNumber,
    int? cvv,
    Timestamp? expiryDate,
    String? ownerId,
  }) =>
      CardEntity(
        id: id ?? this.id,
        cardHolderName: cardHolderName ?? this.cardHolderName,
        cardNumber: cardNumber ?? this.cardNumber,
        cvv: cvv ?? this.cvv,
        expiryDate: expiryDate ?? this.expiryDate,
        ownerId: ownerId ?? this.ownerId,
      );

  factory CardEntity.fromJson(Map<String, dynamic> json) =>
      _$CardEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CardEntityToJson(this);
}
