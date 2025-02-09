import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/features/contact/business/entities/friend_request_entity.dart';

part 'friend_request_model.g.dart';

@JsonSerializable()
class FriendRequestModel extends FriendRequestEntity {
  FriendRequestModel(
      {required super.senderId,
      required super.receiverId,
      required super.status,
      required super.timestamp});

  factory FriendRequestModel.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FriendRequestModelToJson(this);

  factory FriendRequestModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return FriendRequestModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    return toJson()..remove('id');
  }

  FriendRequestEntity toEntity() {
    return FriendRequestEntity(
        senderId: senderId,
        receiverId: receiverId,
        status: status,
        timestamp: timestamp);
  }

  static FriendRequestModel fromEntity(FriendRequestEntity user) {
    return FriendRequestModel(
        senderId: user.senderId,
        receiverId: user.receiverId,
        status: user.status,
        timestamp: user.timestamp);
  }
}
