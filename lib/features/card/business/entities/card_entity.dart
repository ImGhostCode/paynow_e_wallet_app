import 'package:json_annotation/json_annotation.dart';

part 'card_entity.g.dart'; // File được generate

@JsonSerializable()
class CardEntity {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'cardNumber')
  final String cardNumber;
  @JsonKey(name: 'cardHolderName')
  final String cardHolderName;
  @JsonKey(name: 'expiryDate')
  final String expiryDate;
  @JsonKey(name: 'cardType')
  final String cardType;

  CardEntity({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cardType,
  });

  factory CardEntity.fromJson(Map<String, dynamic> json) =>
      _$CardEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CardEntityToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          cardNumber == other.cardNumber &&
          cardHolderName == other.cardHolderName &&
          expiryDate == other.expiryDate &&
          cardType == other.cardType;

  @override
  int get hashCode =>
      id.hashCode ^
      cardNumber.hashCode ^
      cardHolderName.hashCode ^
      expiryDate.hashCode ^
      cardType.hashCode;
}
