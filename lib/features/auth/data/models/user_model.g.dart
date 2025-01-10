// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      avatar: json['avatar'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      balance: (json['balance'] as num).toInt(),
      cards: (json['cards'] as List<dynamic>)
          .map((e) => CardEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: fromJsonCreatedAt(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'avatar': instance.avatar,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'balance': instance.balance,
      'cards': instance.cards,
      'createdAt': Timestamp.fromDate(instance.createdAt),
    };
