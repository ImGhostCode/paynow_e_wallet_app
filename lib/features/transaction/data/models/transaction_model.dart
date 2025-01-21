import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/entities/transaction_entity.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel extends TransactionEntity {
  TransactionModel({
    required super.id,
    required super.senderId,
    required super.receiverId,
    required super.amount,
    required super.status,
    super.note,
    required super.timestamp,
  });

  // factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
  //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //   return TransactionModel.fromJson({'id': doc.id, ...data});
  // }

  // Map<String, dynamic> toFirestore() {
  //   return toJson()..remove('id');
  // }

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      senderId: senderId,
      receiverId: receiverId,
      amount: amount,
      status: status,
      note: note,
      timestamp: timestamp,
    );
  }

  static TransactionModel fromEntity(TransactionEntity card) {
    return TransactionModel(
      id: card.id,
      senderId: card.senderId,
      receiverId: card.receiverId,
      amount: card.amount,
      status: card.status,
      note: card.note,
      timestamp: card.timestamp,
    );
  }
}
