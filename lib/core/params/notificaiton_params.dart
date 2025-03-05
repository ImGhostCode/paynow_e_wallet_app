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
  final String? notificationId;
  final String? senderId;
  final String? receiverId;
  final String? type;

  DelNotificationParams({
    this.notificationId,
    this.senderId,
    this.receiverId,
    this.type,
  });
}
