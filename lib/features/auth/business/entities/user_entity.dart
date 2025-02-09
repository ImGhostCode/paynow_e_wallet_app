import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/features/card/business/entities/card_entity.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';

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
  @JsonKey(
    name: "createdAt",
    toJson: Helper.toJsonTimestamp,
    fromJson: Helper.fromJsonTimestamp,
  )
  final DateTime createdAt;
  @JsonKey(name: "friends")
  final List<String> friends;

  UserEntity({
    this.id,
    required this.avatar,
    required this.email,
    required this.name,
    required this.phone,
    required this.createdAt,
    this.friends = const [],
  });

  UserEntity copyWith({
    String? id,
    String? avatar,
    String? email,
    String? name,
    String? phone,
    List<CardEntity>? cards,
    DateTime? createdAt,
    List<String>? friends,
  }) =>
      UserEntity(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        email: email ?? this.email,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        createdAt: createdAt ?? this.createdAt,
        friends: friends ?? this.friends,
      );

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
