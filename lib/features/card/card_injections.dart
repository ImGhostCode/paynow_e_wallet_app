import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paynow_e_wallet_app/core/utils/injections.dart';
import 'package:paynow_e_wallet_app/features/card/business/repositories/card_repository.dart';
import 'package:paynow_e_wallet_app/features/card/business/usecases/add_card_usecase.dart';
import 'package:paynow_e_wallet_app/features/card/business/usecases/delete_card_usecase.dart';
import 'package:paynow_e_wallet_app/features/card/business/usecases/get_card_usecase.dart';
import 'package:paynow_e_wallet_app/features/card/business/usecases/update_card_usecase.dart';
import 'package:paynow_e_wallet_app/features/card/data/data_sources/card_remote_data_source.dart';
import 'package:paynow_e_wallet_app/features/card/data/data_sources/card_remote_data_source_impl.dart';
import 'package:paynow_e_wallet_app/features/card/data/repositories/card_repositoty_impl.dart';

void initCardInjections() {
  sl.registerSingleton<CardRemoteDataSource>(
      CardRemoteDataSourceImpl(FirebaseFirestore.instance));
  sl.registerSingleton<CardRepository>(CardRepositoryImpl(sl()));
  sl.registerSingleton<GetCardUsecase>(GetCardUsecase(sl()));
  sl.registerSingleton<AddCardUsecase>(AddCardUsecase(sl()));
  sl.registerSingleton<UpdateCardUsecase>(UpdateCardUsecase(sl()));
  sl.registerSingleton<DeleteCardUsecase>(DeleteCardUsecase(sl()));
}
