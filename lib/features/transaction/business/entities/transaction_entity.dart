import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';

part 'transaction_entity.g.dart';

@JsonSerializable()
class TransactionEntity {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "senderId")
  final String senderId;
  @JsonKey(name: "receiverId")
  final String receiverId;
  @JsonKey(name: "amount")
  final double amount;
  @JsonKey(name: "status")
  final String status;
  @JsonKey(name: "note")
  final String? note;
  @JsonKey(
    name: "timestamp",
    toJson: Helper.toJsonTimestamp,
    fromJson: Helper.fromJsonTimestamp,
  )
  final DateTime timestamp;

  TransactionEntity({
    this.id,
    required this.senderId,
    required this.receiverId,
    required this.amount,
    required this.status,
    this.note,
    required this.timestamp,
  });

  TransactionEntity copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    double? amount,
    String? status,
    String? note,
    DateTime? timestamp,
  }) =>
      TransactionEntity(
        id: id ?? this.id,
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        amount: amount ?? this.amount,
        status: status ?? this.status,
        note: note ?? this.note,
        timestamp: timestamp ?? this.timestamp,
      );
  factory TransactionEntity.fromJson(Map<String, dynamic> json) =>
      _$TransactionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionEntityToJson(this);
}
