import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/enum.dart';

part 'transaction_entity.g.dart';

@JsonSerializable()
class TransactionEntity {
  @JsonKey(name: "senderId")
  final String senderId;
  @JsonKey(name: "receiverId")
  final String receiverId;
  @JsonKey(name: "amount")
  final double amount;
  @JsonKey(name: "type")
  final TransactionType type;
  @JsonKey(name: "status")
  final TransactionStatus status;
  @JsonKey(name: "timestamp")
  final String timestamp;
  @JsonKey(name: "description")
  final String description;

  TransactionEntity({
    required this.senderId,
    required this.receiverId,
    required this.amount,
    required this.type,
    required this.status,
    required this.timestamp,
    required this.description,
  });

  TransactionEntity copyWith({
    String? senderId,
    String? receiverId,
    double? amount,
    TransactionType? type,
    TransactionStatus? status,
    String? timestamp,
    String? description,
  }) =>
      TransactionEntity(
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        status: status ?? this.status,
        timestamp: timestamp ?? this.timestamp,
        description: description ?? this.description,
      );

  factory TransactionEntity.fromJson(Map<String, dynamic> json) =>
      _$TransactionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionEntityToJson(this);
}
