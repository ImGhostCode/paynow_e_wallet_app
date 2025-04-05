import 'package:dartz/dartz.dart';
import 'package:paynow_e_wallet_app/core/network/error/failures.dart';
import 'package:paynow_e_wallet_app/core/params/notificaiton_params.dart';
import 'package:paynow_e_wallet_app/features/notification/business/entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<Either<Failure, void>> saveNotification(SaveNotificationParams params);
  Future<Either<Failure, List<NotificationEntity>>> getNotifications(
      GetNotificationsParams params);
  Future<Either<Failure, void>> delNotification(DelNotificationParams params);
  Future<Either<Failure, void>> updateNotification(
      UpdateNotificationParams params);
}
