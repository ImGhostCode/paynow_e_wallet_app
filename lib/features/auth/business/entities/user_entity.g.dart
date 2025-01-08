// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      avatar: json['avatar'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      balance: (json['balance'] as num).toInt(),
      cards: (json['cards'] as List<dynamic>)
          .map((e) => CardEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'email': instance.email,
      'avatar': instance.avatar,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'balance': instance.balance,
      'cards': instance.cards,
      'createdAt': instance.createdAt.toIso8601String(),
    };
