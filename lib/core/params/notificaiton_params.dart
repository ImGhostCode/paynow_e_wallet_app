import 'package:paynow_e_wallet_app/features/notification/business/entities/notification_entity.dart';

class SaveNotificationParams {
  final NotificationEntity notification;

  SaveNotificationParams({
    required this.notification,
  });
}

class GetNotificationsParams {
  final String userId;

  GetNotificationsParams({
    required this.userId,
  });
}

class DelNotificationParams {
  final String notificationId;

  DelNotificationParams({
    required this.notificationId,
  });
}
