import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/exceptions.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/transaction_params.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/entities/transaction_entity.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/repositories/transaction_repository.dart';
import 'package:paynow_e_wallet_app/features/transaction/data/data_sources/transaction_remote_data_source.dart';
import 'package:paynow_e_wallet_app/features/transaction/data/models/transaction_model.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionRemoteDataSource transactionRemoteDataSource;

  TransactionRepositoryImpl(
    this.transactionRemoteDataSource,
  );

  @override
  Future<Either<Failure, TransactionModel>> addTransaction(
      AddTransactionParams params) async {
    try {
      final result = await transactionRemoteDataSource.addTransaction(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransactions(
      String userId) async {
    try {
      final result = await transactionRemoteDataSource.getTransactions(userId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>> getRequests(
      String userId) async {
    try {
      final result = await transactionRemoteDataSource.getRequests(userId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }
}
