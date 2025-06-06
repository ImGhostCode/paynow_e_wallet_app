import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/contact_params.dart';
import 'package:paynow_e_wallet_app/core/utils/usecases/usecase.dart';
import 'package:paynow_e_wallet_app/features/contact/business/entities/friend_request_entity.dart';
import 'package:paynow_e_wallet_app/features/contact/business/repositories/contact_repository.dart';

class GetFriendRequestsUsecase
    extends UseCase<List<FriendRequestEntity>, GetFriendRequestsParams> {
  final ContactRepository repository;

  GetFriendRequestsUsecase(this.repository);

  @override
  Future<Either<Failure, List<FriendRequestEntity>>> call(
      GetFriendRequestsParams params) async {
    final result = await repository.getFriendRequests(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
