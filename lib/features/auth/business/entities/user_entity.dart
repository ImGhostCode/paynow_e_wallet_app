import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/features/card/business/entities/card_entity.dart';

part 'user_entity.g.dart';

DateTime fromJsonCreatedAt(Timestamp timestamp) {
  return timestamp.toDate();
}

@JsonSerializable()
class UserEntity {
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "avatar")
  final String avatar;
  @JsonKey(name: "fullName")
  final String fullName;
  @JsonKey(name: "phoneNumber")
  final String phoneNumber;
  @JsonKey(name: "balance")
  final int balance;
  @JsonKey(name: "cards")
  final List<CardEntity> cards;
  @JsonKey(
      name: "createdAt",
      fromJson: fromJsonCreatedAt,
      toJson: Timestamp.fromDate)
  final DateTime createdAt;

  UserEntity({
    required this.avatar,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.balance,
    required this.cards,
    required this.createdAt,
  });

  UserEntity copyWith({
    String? avatar,
    String? email,
    String? fullName,
    String? phoneNumber,
    int? balance,
    List<CardEntity>? cards,
    DateTime? createdAt,
  }) =>
      UserEntity(
        avatar: avatar ?? this.avatar,
        email: email ?? this.email,
        fullName: fullName ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        balance: balance ?? this.balance,
        cards: cards ?? this.cards,
        createdAt: createdAt ?? this.createdAt,
      );

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
