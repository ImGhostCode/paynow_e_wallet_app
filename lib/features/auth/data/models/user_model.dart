// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/features/auth/business/entities/user_entity.dart';
import 'package:paynow_e_wallet_app/features/card/business/entities/card_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  UserModel(
      {required super.avatar,
      required super.email,
      required super.fullName,
      required super.phoneNumber,
      required super.balance,
      required super.cards,
      required super.createdAt});

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
        avatar: avatar,
        email: email,
        fullName: fullName,
        phoneNumber: phoneNumber,
        balance: balance,
        cards: cards,
        createdAt: createdAt);
  }

  static UserModel fromEntity(UserEntity user) {
    return UserModel(
        avatar: user.avatar,
        email: user.email,
        fullName: user.fullName,
        phoneNumber: user.phoneNumber,
        balance: user.balance,
        cards: user.cards,
        createdAt: user.createdAt);
  }
}
