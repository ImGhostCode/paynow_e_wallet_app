import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/contact_params.dart';
import 'package:paynow_e_wallet_app/core/utils/usecases/usecase.dart';
import 'package:paynow_e_wallet_app/features/contact/business/repositories/contact_repository.dart';

class UnfriendUsecase extends UseCase<void, UnfriendParams> {
  final ContactRepository repository;

  UnfriendUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(UnfriendParams params) async {
    final result = await repository.unfriend(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
