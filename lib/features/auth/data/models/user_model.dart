// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';
import 'package:paynow_e_wallet_app/features/auth/business/entities/user_entity.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  UserModel(
      {super.id,
      required super.avatar,
      required super.email,
      required super.name,
      required super.phone,
      required super.createdAt,
      super.friends = const []});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    return toJson()..remove('id');
  }

  UserEntity toEntity() {
    return UserEntity(
        id: id,
        avatar: avatar,
        email: email,
        name: name,
        phone: phone,
        createdAt: createdAt,
        friends: friends);
  }

  static UserModel fromEntity(UserEntity user) {
    return UserModel(
        id: user.id,
        avatar: user.avatar,
        email: user.email,
        name: user.name,
        phone: user.phone,
        createdAt: user.createdAt,
        friends: user.friends);
  }
}
