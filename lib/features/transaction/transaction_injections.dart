import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paynow_e_wallet_app/core/utils/injections.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/repositories/transaction_repository.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/usecases/accept_request_usecase.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/usecases/add_transactions_usecase.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/usecases/get_requests_usecase.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/usecases/get_transactions_usecase.dart';
import 'package:paynow_e_wallet_app/features/transaction/data/data_sources/transaction_remote_data_source.dart';
import 'package:paynow_e_wallet_app/features/transaction/data/data_sources/transaction_remote_data_source_impl.dart';
import 'package:paynow_e_wallet_app/features/transaction/data/repositories/transaction_repositoy_impl.dart';

void initTransactionInjections() {
  sl.registerSingleton<TransactionRemoteDataSource>(
      TransactionRemoteDataSourceImpl(FirebaseFirestore.instance));
  sl.registerSingleton<TransactionRepository>(TransactionRepositoryImpl(sl()));
  sl.registerSingleton<GetTransactionsUsecase>(GetTransactionsUsecase(sl()));
  sl.registerSingleton<AddTransactionUsecase>(AddTransactionUsecase(sl()));
  sl.registerSingleton<GetRequestsUsecase>(GetRequestsUsecase(sl()));
  sl.registerSingleton<AcceptRequestUsecase>(AcceptRequestUsecase(sl()));
}
