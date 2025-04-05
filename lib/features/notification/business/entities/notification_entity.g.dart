// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationEntity _$NotificationEntityFromJson(Map<String, dynamic> json) =>
    NotificationEntity(
      id: json['id'] as String?,
      senderId: json['senderId'] as String?,
      receiverId: json['receiverId'] as String?,
      type: json['type'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      isRead: json['isRead'] as bool?,
      timestamp: Helper.fromJsonTimestamp(json['timestamp'] as Timestamp),
    );

Map<String, dynamic> _$NotificationEntityToJson(NotificationEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'type': instance.type,
      'data': instance.data,
      'isRead': instance.isRead,
      'timestamp': Helper.toJsonTimestamp(instance.timestamp),
    };
