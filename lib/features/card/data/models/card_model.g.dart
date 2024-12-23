// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardModel _$CardModelFromJson(Map<String, dynamic> json) => CardModel(
      id: json['id'] as String,
      cardNumber: json['cardNumber'] as String,
      cardHolderName: json['cardHolderName'] as String,
      expiryDate: json['expiryDate'] as String,
      cardType: json['cardType'] as String,
    );

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
      'id': instance.id,
      'cardNumber': instance.cardNumber,
      'cardHolderName': instance.cardHolderName,
      'expiryDate': instance.expiryDate,
      'cardType': instance.cardType,
    };
