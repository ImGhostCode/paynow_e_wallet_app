// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendRequestModel _$FriendRequestModelFromJson(Map<String, dynamic> json) =>
    FriendRequestModel(
      senderId: json['senderId'] as String?,
      receiverId: json['receiverId'] as String?,
      status: json['status'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$FriendRequestModelToJson(FriendRequestModel instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'status': instance.status,
      'timestamp': instance.timestamp.toIso8601String(),
    };
