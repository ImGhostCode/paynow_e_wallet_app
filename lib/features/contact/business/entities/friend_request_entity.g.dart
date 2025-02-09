// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendRequestEntity _$FriendRequestEntityFromJson(Map<String, dynamic> json) =>
    FriendRequestEntity(
      senderId: json['senderId'] as String?,
      receiverId: json['receiverId'] as String?,
      status: json['status'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$FriendRequestEntityToJson(
        FriendRequestEntity instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'status': instance.status,
      'timestamp': instance.timestamp.toIso8601String(),
    };
