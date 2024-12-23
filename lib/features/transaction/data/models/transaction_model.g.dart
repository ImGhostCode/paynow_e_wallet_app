// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as TransactionType,
      status: json['status'] as TransactionStatus,
      timestamp: json['timestamp'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'amount': instance.amount,
      'type': instance.type,
      'status': instance.status,
      'timestamp': instance.timestamp,
      'description': instance.description,
    };
