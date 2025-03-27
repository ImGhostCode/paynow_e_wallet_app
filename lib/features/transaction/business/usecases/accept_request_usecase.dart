import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/transaction_params.dart';
import 'package:paynow_e_wallet_app/core/utils/usecases/usecase.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/repositories/transaction_repository.dart';

class AcceptRequestUsecase extends UseCase<void, AcceptRequestParams> {
  final TransactionRepository repository;

  AcceptRequestUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(AcceptRequestParams params) async {
    final result = await repository.acceptRequest(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
