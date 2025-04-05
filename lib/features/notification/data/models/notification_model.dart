import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';
import 'package:paynow_e_wallet_app/features/notification/business/entities/notification_entity.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel extends NotificationEntity {
  NotificationModel(
      {super.id,
      required super.senderId,
      required super.receiverId,
      required super.type,
      required super.data,
      required super.isRead,
      required super.timestamp});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return NotificationModel.fromJson({...data, 'id': doc.id});
  }

  @override
  Map<String, dynamic> toFirestore() {
    return toJson()..remove('id');
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
        id: id,
        senderId: senderId,
        receiverId: receiverId,
        type: type,
        data: data,
        isRead: isRead,
        timestamp: timestamp);
  }

  static NotificationModel fromEntity(NotificationEntity user) {
    return NotificationModel(
        id: user.id,
        senderId: user.senderId,
        receiverId: user.receiverId,
        type: user.type,
        data: user.data,
        isRead: user.isRead,
        timestamp: user.timestamp);
  }
}
