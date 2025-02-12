import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/contact_params.dart';
import 'package:paynow_e_wallet_app/core/utils/usecases/usecase.dart';
import 'package:paynow_e_wallet_app/features/auth/business/entities/user_entity.dart';
import 'package:paynow_e_wallet_app/features/contact/business/repositories/contact_repository.dart';

class GetFriendsUsecase extends UseCase<List<UserEntity>, GetFriendsParams> {
  final ContactRepository repository;

  GetFriendsUsecase(this.repository);

  @override
  Future<Either<Failure, List<UserEntity>>> call(
      GetFriendsParams params) async {
    final result = await repository.getFriends(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
