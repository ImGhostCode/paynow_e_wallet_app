import 'package:paynow_e_wallet_app/core/params/transaction_params.dart';
import 'package:paynow_e_wallet_app/features/transaction/data/models/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Future<List<TransactionModel>> getTransactions(String userId);
  Future<List<TransactionModel>> getRequests(String userId);
  Future<TransactionModel> addTransaction(AddTransactionParams params);
  Future<void> acceptRequest(AcceptRequestParams params);
}
