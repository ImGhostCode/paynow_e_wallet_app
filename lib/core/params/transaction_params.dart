import 'package:paynow_e_wallet_app/features/transaction/business/entities/transaction_entity.dart';

final class AddTransactionParams {
  final TransactionEntity transaction;

  AddTransactionParams(this.transaction);
}

final class AcceptRequestParams {
  final TransactionEntity transaction;

  AcceptRequestParams(this.transaction);
}

final class AcceptAllRequestParams {
  final List<TransactionEntity> transactions;

  AcceptAllRequestParams(this.transactions);
}
