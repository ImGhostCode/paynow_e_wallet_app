import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/features/card/business/entities/card_entity.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "avatar")
  final String avatar;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "phone")
  final String phone;
  @JsonKey(name: "cards")
  final List<CardEntity> cards;
  @JsonKey(
    name: "createdAt",
  )
  final Timestamp createdAt;

  UserEntity({
    this.id,
    required this.avatar,
    required this.email,
    required this.name,
    required this.phone,
    required this.cards,
    required this.createdAt,
  });

  UserEntity copyWith({
    String? id,
    String? avatar,
    String? email,
    String? name,
    String? phone,
    List<CardEntity>? cards,
    Timestamp? createdAt,
  }) =>
      UserEntity(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        email: email ?? this.email,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        cards: cards ?? this.cards,
        createdAt: createdAt ?? this.createdAt,
      );

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
