import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/enum.dart';
import 'package:paynow_e_wallet_app/features/transaction/bussiness/entities/transaction_entity.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel extends TransactionEntity {
  TransactionModel({
    required super.senderId,
    required super.receiverId,
    required super.amount,
    required super.type,
    required super.status,
    required super.timestamp,
    required super.description,
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
        senderId: senderId,
        receiverId: receiverId,
        amount: amount,
        type: type,
        status: status,
        timestamp: timestamp,
        description: description);
  }

  static TransactionModel fromEntity(TransactionEntity card) {
    return TransactionModel(
        senderId: card.senderId,
        receiverId: card.receiverId,
        amount: card.amount,
        type: card.type,
        status: card.status,
        timestamp: card.timestamp,
        description: card.description);
  }
}
