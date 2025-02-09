// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      id: json['id'] as String?,
      avatar: json['avatar'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      createdAt: Helper.fromJsonTimestamp(json['createdAt'] as Timestamp),
      friends: (json['friends'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'avatar': instance.avatar,
      'name': instance.name,
      'phone': instance.phone,
      'createdAt': Helper.toJsonTimestamp(instance.createdAt),
      'friends': instance.friends,
    };
