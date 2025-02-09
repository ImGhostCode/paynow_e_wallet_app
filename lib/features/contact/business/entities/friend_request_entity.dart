import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';

part 'friend_request_entity.g.dart';

@JsonSerializable()
class FriendRequestEntity {
  @JsonKey(name: "senderId")
  final String? senderId;
  @JsonKey(name: "receiverId")
  final String? receiverId;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "timestamp")
  @JsonKey(
    name: "createdAt",
    toJson: Helper.toJsonTimestamp,
    fromJson: Helper.fromJsonTimestamp,
  )
  final DateTime timestamp;

  FriendRequestEntity({
    required this.senderId,
    required this.receiverId,
    required this.status,
    required this.timestamp,
  });

  FriendRequestEntity copyWith({
    String? senderId,
    String? receiverId,
    String? status,
    DateTime? timestamp,
  }) =>
      FriendRequestEntity(
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        status: status ?? this.status,
        timestamp: timestamp ?? this.timestamp,
      );

  factory FriendRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FriendRequestEntityToJson(this);
}
