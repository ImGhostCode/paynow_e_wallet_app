import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';

part 'transaction_entity.g.dart';

@JsonSerializable()
class TransactionEntity {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "transaction_type")
  final String transactionType;
  @JsonKey(name: "senderId")
  final String senderId;
  @JsonKey(name: "receiverId")
  final String receiverId;
  @JsonKey(name: "amount")
  final double amount;
  @JsonKey(name: "status")
  final String status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(
    name: "timestamp",
    toJson: Helper.toJsonTimestamp,
    fromJson: Helper.fromJsonTimestamp,
  )
  final DateTime timestamp;

  TransactionEntity({
    this.id,
    required this.transactionType,
    required this.senderId,
    required this.receiverId,
    required this.amount,
    required this.status,
    this.message,
    required this.timestamp,
  });

  TransactionEntity copyWith({
    String? id,
    String? transactionType,
    String? senderId,
    String? receiverId,
    double? amount,
    String? status,
    String? message,
    DateTime? timestamp,
  }) =>
      TransactionEntity(
        id: id ?? this.id,
        transactionType: transactionType ?? this.transactionType,
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        amount: amount ?? this.amount,
        status: status ?? this.status,
        message: message ?? this.message,
        timestamp: timestamp ?? this.timestamp,
      );
  factory TransactionEntity.fromJson(Map<String, dynamic> json) =>
      _$TransactionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionEntityToJson(this);

  factory TransactionEntity.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TransactionEntity.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    return toJson()..remove('id');
  }
}


// send money : senderId == currentUserId
// request money : receiverId == currentUserId
// status : pending, completed, failed