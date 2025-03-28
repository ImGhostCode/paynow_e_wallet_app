import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/transaction_params.dart';
import 'package:paynow_e_wallet_app/core/utils/usecases/usecase.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/repositories/transaction_repository.dart';

class AcceptAllRequestsUsecase extends UseCase<void, AcceptAllRequestParams> {
  final TransactionRepository repository;

  AcceptAllRequestsUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(AcceptAllRequestParams params) async {
    final result = await repository.acceptAllRequests(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
