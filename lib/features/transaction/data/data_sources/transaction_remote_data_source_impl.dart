import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paynow_e_wallet_app/core/network/error/exceptions.dart';
import 'package:paynow_e_wallet_app/core/params/transaction_params.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/app_constants.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/enum.dart';
import 'package:paynow_e_wallet_app/features/transaction/data/data_sources/transaction_remote_data_source.dart';
import 'package:paynow_e_wallet_app/features/transaction/data/models/transaction_model.dart';

class TransactionRemoteDataSourceImpl extends TransactionRemoteDataSource {
  final FirebaseFirestore _firestore;

  TransactionRemoteDataSourceImpl(this._firestore);

  @override
  Future<TransactionModel> addTransaction(AddTransactionParams params) async {
    try {
      if (params.transaction.transactionType == TransactionType.send.name) {
        final senderCard = _firestore
            .collection(Collection.cards.name)
            .where(kDefaultCard, isEqualTo: true)
            .where(kOwnerId, isEqualTo: params.transaction.senderId);
        final receiverCard = _firestore
            .collection(Collection.cards.name)
            .where(kDefaultCard, isEqualTo: true)
            .where(kOwnerId, isEqualTo: params.transaction.receiverId);

        final sender = await senderCard.get();
        final receiver = await receiverCard.get();

        if (sender.docs.isEmpty) {
          throw 'Sender has not added card';
        }

        if (receiver.docs.isEmpty) {
          throw 'User has not added card';
        }

        final senderBalance = sender.docs.first.data()[kBalance] as double;
        final receiverBalance = receiver.docs.first.data()[kBalance] as double;

        if (senderBalance < params.transaction.amount) {
          throw 'Insufficient balance';
        }

        await _firestore.runTransaction((transaction) async {
          transaction.update(
            sender.docs.first.reference,
            {kBalance: senderBalance - params.transaction.amount},
          );
          transaction.update(
            receiver.docs.first.reference,
            {kBalance: receiverBalance + params.transaction.amount},
          );
        });
      }

      final result = await _firestore
          .collection(Collection.transactions.name)
          .add(params.transaction
              .copyWith(
                status: params.transaction.transactionType ==
                        TransactionType.send.name
                    ? TransactionStatus.completed.name
                    : params.transaction.status,
              )
              .toFirestore());

      return TransactionModel.fromFirestore(await result.get());
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      await _firestore
          .collection(Collection.transactions.name)
          .add(params.transaction
              .copyWith(
                status: TransactionStatus.failed.name,
              )
              .toFirestore());
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<List<TransactionModel>> getTransactions(String userId) async {
    try {
      List<TransactionModel> transactions = [];
      final sendingTransactions = await _firestore
          .collection(Collection.transactions.name)
          .where(
            'senderId',
            isEqualTo: userId,
          )
          .where('status', isNotEqualTo: TransactionStatus.failed.name)
          .get();

      final recievedTransactions = await _firestore
          .collection(Collection.transactions.name)
          .where('receiverId', isEqualTo: userId)
          .where('status', isNotEqualTo: TransactionStatus.failed.name)
          .get();
      transactions.addAll(sendingTransactions.docs
          .map((e) => TransactionModel.fromFirestore(e))
          .toList());
      transactions.addAll(recievedTransactions.docs
          .map((e) => TransactionModel.fromFirestore(e))
          .toList());
      return transactions;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<List<TransactionModel>> getRequests(String userId) async {
    try {
      final transactions = await _firestore
          .collection(Collection.transactions.name)
          .where(kReceiverId, isEqualTo: userId)
          .where(kTransactionType, isEqualTo: TransactionType.request.name)
          .where(kStatus, isEqualTo: TransactionStatus.pending.name)
          .get();
      return transactions.docs
          .map((e) => TransactionModel.fromFirestore(e))
          .toList();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}
