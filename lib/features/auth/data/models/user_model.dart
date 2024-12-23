// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/features/auth/bussiness/entities/user_entity.dart';
import 'package:paynow_e_wallet_app/features/card/bussiness/entities/card_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  UserModel(
      {required super.email,
      required super.fullName,
      required super.phoneNumber,
      required super.balance,
      required super.cards});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  // factory UserModel.fromFirestore(DocumentSnapshot doc) {
  //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //   return UserModel.fromJson({'id': doc.id, ...data});
  // }

  // Map<String, dynamic> toFirestore() {
  //   return toJson()..remove('id');
  // }

  UserEntity toEntity() {
    return UserEntity(
        email: email,
        fullName: fullName,
        phoneNumber: phoneNumber,
        balance: balance,
        cards: cards);
  }

  static UserModel fromEntity(UserEntity card) {
    return UserModel(
        email: card.email,
        fullName: card.fullName,
        phoneNumber: card.phoneNumber,
        balance: card.balance,
        cards: card.cards);
  }
}
