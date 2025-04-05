import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paynow_e_wallet_app/core/network/error/exceptions.dart';
import 'package:paynow_e_wallet_app/core/params/notificaiton_params.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/enum.dart';
import 'package:paynow_e_wallet_app/features/notification/data/data_sources/noti_remote_data_source.dart';
import 'package:paynow_e_wallet_app/features/notification/data/models/notification_model.dart';

class NotiRemoteDataSourceImpl extends NotiRemoteDataSource {
  final FirebaseFirestore _firestore;

  NotiRemoteDataSourceImpl(this._firestore);

  @override
  Future<List<NotificationModel>> getNotifications(
      GetNotificationsParams params) async {
    try {
      final result = await _firestore
          .collection(Collection.notifications.name)
          .where('receiverId', isEqualTo: params.userId)
          .get();

      return result.docs
          .map((e) => NotificationModel.fromFirestore(e))
          .toList();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<void> saveNotification(SaveNotificationParams params) async {
    try {
      await _firestore
          .collection(Collection.notifications.name)
          .add(params.notification.toFirestore());
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<void> delNotification(DelNotificationParams params) async {
    try {
      if (params.notificationId != null) {
        await _firestore
            .collection(Collection.notifications.name)
            .doc(params.notificationId)
            .delete();
      } else if (params.senderId != null &&
          params.receiverId != null &&
          params.type != null) {
        final result = await _firestore
            .collection(Collection.notifications.name)
            .where('senderId', isEqualTo: params.senderId)
            .where('receiverId', isEqualTo: params.receiverId)
            .where('type', isEqualTo: params.type)
            .get();

        for (var doc in result.docs) {
          await doc.reference.delete();
        }
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<void> updNotification(UpdateNotificationParams params) async {
    try {
      await _firestore
          .collection(Collection.notifications.name)
          .doc(params.notificationId)
          .update(params.notification.toFirestore());
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}
