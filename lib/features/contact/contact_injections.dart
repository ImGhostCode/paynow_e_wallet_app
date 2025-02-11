import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paynow_e_wallet_app/core/utils/injections.dart';
import 'package:paynow_e_wallet_app/features/contact/business/repositories/contact_repository.dart';
import 'package:paynow_e_wallet_app/features/contact/business/usecases/cancel_fr_usecase.dart';
import 'package:paynow_e_wallet_app/features/contact/business/usecases/get_contact_status_usecase.dart';
import 'package:paynow_e_wallet_app/features/contact/business/usecases/get_friend_requests_usecase.dart';
import 'package:paynow_e_wallet_app/features/contact/business/usecases/get_friends_usecase.dart';
import 'package:paynow_e_wallet_app/features/contact/business/usecases/get_user_by_email_usecase.dart';
import 'package:paynow_e_wallet_app/features/contact/business/usecases/response_to_fr_usecase.dart';
import 'package:paynow_e_wallet_app/features/contact/business/usecases/send_fr_usecase.dart';
import 'package:paynow_e_wallet_app/features/contact/business/usecases/unfriend_usecase.dart';
import 'package:paynow_e_wallet_app/features/contact/data/data_sources/contact_remote_data_source.dart';
import 'package:paynow_e_wallet_app/features/contact/data/data_sources/contact_remote_data_source_impl.dart';
import 'package:paynow_e_wallet_app/features/contact/data/repositories/contact_repository_impl.dart';

void initContactInjections() {
  sl.registerSingleton<ContactRemoteDataSource>(
      ContactRemoteDataSourceImpl(FirebaseFirestore.instance));
  sl.registerSingleton<ContactRepository>(ContactRepositoryImpl(sl()));
  sl.registerSingleton<SendFriendRequestUsecase>(
      SendFriendRequestUsecase(sl()));
  sl.registerSingleton<CancelFrUsecase>(CancelFrUsecase(sl()));
  sl.registerSingleton<ResponseToFrUsecase>(ResponseToFrUsecase(sl()));
  sl.registerSingleton<GetFriendRequestsUsecase>(
      GetFriendRequestsUsecase(sl()));
  sl.registerSingleton<GetFriendsUsecase>(GetFriendsUsecase(sl()));
  sl.registerSingleton<GetUserByEmailUsecase>(GetUserByEmailUsecase(sl()));
  sl.registerSingleton<UnfriendUsecase>(UnfriendUsecase(sl()));
  sl.registerSingleton<GetContactStatusUsecase>(GetContactStatusUsecase(sl()));
}
