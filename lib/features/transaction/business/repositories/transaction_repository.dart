import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/transaction_params.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<Either<Failure, List<TransactionEntity>>> getTransactions(
      String userId);
  Future<Either<Failure, List<TransactionEntity>>> getRequests(String userId);
  Future<Either<Failure, TransactionEntity>> addTransaction(
      AddTransactionParams params);
  Future<Either<Failure, void>> acceptRequest(AcceptRequestParams params);
  Future<Either<Failure, void>> acceptAllRequests(
      AcceptAllRequestParams params);
}
