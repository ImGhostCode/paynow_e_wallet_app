import 'package:paynow_e_wallet_app/core/params/notificaiton_params.dart';
import 'package:paynow_e_wallet_app/features/notification/data/models/notification_model.dart';

abstract class NotiRemoteDataSource {
  Future<void> saveNotification(SaveNotificationParams params);
  Future<List<NotificationModel>> getNotifications(
      GetNotificationsParams params);
  Future<void> delNotification(DelNotificationParams params);
}
