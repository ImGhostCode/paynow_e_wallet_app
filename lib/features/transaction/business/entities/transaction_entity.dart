import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

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
  final int amount;
  @JsonKey(name: "status")
  final String status;
  @JsonKey(
    name: "timestamp",
  )
  final Timestamp timestamp;

  TransactionEntity({
    this.id,
    required this.senderId,
    required this.receiverId,
    required this.amount,
    required this.status,
    required this.timestamp,
  });

  TransactionEntity copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    int? amount,
    String? status,
    Timestamp? timestamp,
  }) =>
      TransactionEntity(
        id: id ?? this.id,
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        amount: amount ?? this.amount,
        status: status ?? this.status,
        timestamp: timestamp ?? this.timestamp,
      );
  Timestamp test = Timestamp.now();
  factory TransactionEntity.fromJson(Map<String, dynamic> json) =>
      _$TransactionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionEntityToJson(this);
}
