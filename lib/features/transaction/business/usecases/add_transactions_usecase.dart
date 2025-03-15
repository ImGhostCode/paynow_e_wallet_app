import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/transaction_params.dart';
import 'package:paynow_e_wallet_app/core/utils/usecases/usecase.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/entities/transaction_entity.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/repositories/transaction_repository.dart';

class AddTransactionUsecase
    extends UseCase<TransactionEntity, AddTransactionParams> {
  final TransactionRepository repository;

  AddTransactionUsecase(this.repository);

  @override
  Future<Either<Failure, TransactionEntity>> call(
      AddTransactionParams params) async {
    final result = await repository.addTransaction(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
