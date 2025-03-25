import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/utils/usecases/usecase.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/entities/transaction_entity.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/repositories/transaction_repository.dart';

class GetRequestsUsecase extends UseCase<List<TransactionEntity>, String> {
  final TransactionRepository repository;

  GetRequestsUsecase(this.repository);

  @override
  Future<Either<Failure, List<TransactionEntity>>> call(String params) async {
    final result = await repository.getRequests(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
