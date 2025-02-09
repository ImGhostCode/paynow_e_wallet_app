import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/contact_params.dart';
import 'package:paynow_e_wallet_app/core/utils/usecases/usecase.dart';
import 'package:paynow_e_wallet_app/features/contact/business/repositories/contact_repository.dart';

class SendFriendRequestUsecase extends UseCase<void, SendFriendRequestParams> {
  final ContactRepository repository;

  SendFriendRequestUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(SendFriendRequestParams params) async {
    final result = await repository.sendFriendRequest(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
