import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/entities/transaction_entity.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel extends TransactionEntity {
  TransactionModel({
    required super.id,
    required super.transactionType,
    required super.senderId,
    required super.receiverId,
    required super.amount,
    required super.status,
    super.message,
    required super.timestamp,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      transactionType: transactionType,
      senderId: senderId,
      receiverId: receiverId,
      amount: amount,
      status: status,
      message: message,
      timestamp: timestamp,
    );
  }

  static TransactionModel fromEntity(TransactionEntity card) {
    return TransactionModel(
      id: card.id,
      transactionType: card.transactionType,
      senderId: card.senderId,
      receiverId: card.receiverId,
      amount: card.amount,
      status: card.status,
      message: card.message,
      timestamp: card.timestamp,
    );
  }

  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TransactionModel.fromJson({...data, 'id': doc.id});
  }

  @override
  Map<String, dynamic> toFirestore() {
    return toJson()..remove('id');
  }
}
