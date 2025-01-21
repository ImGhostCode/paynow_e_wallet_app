// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardModel _$CardModelFromJson(Map<String, dynamic> json) => CardModel(
      id: json['id'] as String?,
      cardNumber: json['cardNumber'] as String,
      cardHolderName: json['cardHolderName'] as String,
      expiryDate: Helper.fromJsonTimestamp(json['expiryDate'] as Timestamp),
      cvv: (json['cvv'] as num).toInt(),
      ownerId: json['ownerId'] as String,
    );

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
      'id': instance.id,
      'cardHolderName': instance.cardHolderName,
      'cardNumber': instance.cardNumber,
      'cvv': instance.cvv,
      'expiryDate': Helper.toJsonTimestamp(instance.expiryDate),
      'ownerId': instance.ownerId,
    };
