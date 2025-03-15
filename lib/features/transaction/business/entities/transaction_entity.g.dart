// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionEntity _$TransactionEntityFromJson(Map<String, dynamic> json) =>
    TransactionEntity(
      id: json['id'] as String?,
      transactionType: json['transaction_type'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String,
      message: json['message'] as String?,
      timestamp: Helper.fromJsonTimestamp(json['timestamp'] as Timestamp),
    );

Map<String, dynamic> _$TransactionEntityToJson(TransactionEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transaction_type': instance.transactionType,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'amount': instance.amount,
      'status': instance.status,
      'message': instance.message,
      'timestamp': Helper.toJsonTimestamp(instance.timestamp),
    };
