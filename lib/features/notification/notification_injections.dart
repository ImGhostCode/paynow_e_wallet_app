import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paynow_e_wallet_app/core/utils/injections.dart';
import 'package:paynow_e_wallet_app/features/notification/business/repositories/notification_repository.dart';
import 'package:paynow_e_wallet_app/features/notification/business/usecases/del_notification_usecase.dart';
import 'package:paynow_e_wallet_app/features/notification/business/usecases/get_notifications_usecase.dart';
import 'package:paynow_e_wallet_app/features/notification/business/usecases/save_notification_usecase.dart';
import 'package:paynow_e_wallet_app/features/notification/data/data_sources/noti_remote_data_source.dart';
import 'package:paynow_e_wallet_app/features/notification/data/data_sources/noti_remote_data_source_impl.dart';
import 'package:paynow_e_wallet_app/features/notification/data/repositories/notification_repository_impl.dart';

void initNotificationInjections() {
  sl.registerSingleton<NotiRemoteDataSource>(
      NotiRemoteDataSourceImpl(FirebaseFirestore.instance));
  sl.registerSingleton<NotificationRepository>(
      NotificationRepositoryImpl(sl()));
  sl.registerSingleton<SaveNotificationUsecase>(SaveNotificationUsecase(sl()));
  sl.registerSingleton<GetNotificationsUsecase>(GetNotificationsUsecase(sl()));
  sl.registerSingleton<DelNotificationUsecase>(DelNotificationUsecase(sl()));
}
