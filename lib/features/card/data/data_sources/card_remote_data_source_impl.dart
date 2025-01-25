import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paynow_e_wallet_app/core/network/error/exceptions.dart';
import 'package:paynow_e_wallet_app/core/params/card_params.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/enum.dart';
import 'package:paynow_e_wallet_app/features/card/data/data_sources/card_remote_data_source.dart';
import 'package:paynow_e_wallet_app/features/card/data/models/card_model.dart';

class CardRemoteDataSourceImpl extends CardRemoteDataSource {
  final FirebaseFirestore _firestore;

  CardRemoteDataSourceImpl(this._firestore);

  @override
  Future<List<CardModel>> getCard(String userId) async {
    try {
      final result = await _firestore
          .collection(Collection.cards.name)
          .where('ownerId', isEqualTo: userId)
          .get();
      return result.docs.map((e) => CardModel.fromFirestore(e)).toList();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<CardModel> addCard(AddCardParams params) async {
    try {
      final result = await _firestore
          .collection(Collection.cards.name)
          .add(params.card.toFirestore());
      return CardModel.fromFirestore(await result.get());
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<void> deleteCard(String id) async {
    try {
      await _firestore.collection(Collection.cards.name).doc(id).delete();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<void> updateCard(UpdateCardParams params) async {
    try {
      await _firestore
          .collection(Collection.cards.name)
          .doc(params.card.id)
          .update(params.card.toFirestore());
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}
