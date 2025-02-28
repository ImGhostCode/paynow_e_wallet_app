import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/notificaiton_params.dart';
import 'package:paynow_e_wallet_app/core/utils/usecases/usecase.dart';
import 'package:paynow_e_wallet_app/features/notification/business/entities/notification_entity.dart';
import 'package:paynow_e_wallet_app/features/notification/business/repositories/notification_repository.dart';

class GetNotificationsUsecase
    extends UseCase<List<NotificationEntity>, GetNotificationsParams> {
  final NotificationRepository repository;

  GetNotificationsUsecase(this.repository);

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(
      GetNotificationsParams params) async {
    final result = await repository.getNotifications(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
