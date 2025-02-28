import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';

part 'notification_entity.g.dart';

@JsonSerializable()
class NotificationEntity {
  @JsonKey(name: "senderId")
  final String? senderId;
  @JsonKey(name: "receiverId")
  final String? receiverId;
  @JsonKey(name: "type")
  final String? type;
  // @JsonKey(name: "message")
  // final String? message;
  @JsonKey(name: "data")
  final Map<String, dynamic>? data;
  @JsonKey(name: "isRead")
  final bool? isRead;
  @JsonKey(
    name: "timestamp",
    toJson: Helper.toJsonTimestamp,
    fromJson: Helper.fromJsonTimestamp,
  )
  final DateTime timestamp;

  NotificationEntity({
    required this.senderId,
    required this.receiverId,
    required this.type,
    // required this.message,
    required this.data,
    required this.isRead,
    required this.timestamp,
  });

  NotificationEntity copyWith({
    String? senderId,
    String? receiverId,
    String? type,
    // String? message,
    Map<String, dynamic>? data,
    bool? isRead,
    DateTime? timestamp,
  }) =>
      NotificationEntity(
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        type: type ?? this.type,
        // message: message ?? this.message,
        data: data ?? this.data,
        isRead: isRead ?? this.isRead,
        timestamp: timestamp ?? this.timestamp,
      );

  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationEntityToJson(this);

  factory NotificationEntity.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return NotificationEntity.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    return toJson()..remove('id');
  }
}
