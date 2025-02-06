// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardEntity _$CardEntityFromJson(Map<String, dynamic> json) => CardEntity(
      id: json['id'] as String?,
      cardHolderName: json['cardHolderName'] as String,
      cardNumber: json['cardNumber'] as String,
      cvv: (json['cvv'] as num).toInt(),
      expiryDate: Helper.fromJsonTimestamp(json['expiryDate'] as Timestamp),
      ownerId: json['ownerId'] as String,
      balance: (json['balance'] as num).toDouble(),
      defaultCard: json['defaultCard'] as bool,
    );

Map<String, dynamic> _$CardEntityToJson(CardEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardHolderName': instance.cardHolderName,
      'cardNumber': instance.cardNumber,
      'cvv': instance.cvv,
      'expiryDate': Helper.toJsonTimestamp(instance.expiryDate),
      'ownerId': instance.ownerId,
      'balance': instance.balance,
      'defaultCard': instance.defaultCard,
    };
