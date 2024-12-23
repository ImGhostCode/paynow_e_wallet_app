import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/features/card/bussiness/entities/card_entity.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "fullName")
  final String fullName;
  @JsonKey(name: "phoneNumber")
  final String phoneNumber;
  @JsonKey(name: "balance")
  final int balance;
  @JsonKey(name: "cards")
  final List<CardEntity> cards;

  UserEntity({
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.balance,
    required this.cards,
  });

  UserEntity copyWith({
    String? email,
    String? fullName,
    String? phoneNumber,
    int? balance,
    List<CardEntity>? cards,
  }) =>
      UserEntity(
        email: email ?? this.email,
        fullName: fullName ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        balance: balance ?? this.balance,
        cards: cards ?? this.cards,
      );

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
