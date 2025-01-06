// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionEntity _$TransactionEntityFromJson(Map<String, dynamic> json) =>
    TransactionEntity(
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      status: $enumDecode(_$TransactionStatusEnumMap, json['status']),
      timestamp: json['timestamp'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$TransactionEntityToJson(TransactionEntity instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'amount': instance.amount,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'status': _$TransactionStatusEnumMap[instance.status]!,
      'timestamp': instance.timestamp,
      'description': instance.description,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.send: 'send',
  TransactionType.request: 'request',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.pending: 'pending',
  TransactionStatus.completed: 'completed',
  TransactionStatus.failed: 'failed',
};
