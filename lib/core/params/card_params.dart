import 'package:paynow_e_wallet_app/features/card/business/entities/card_entity.dart';

final class AddCardParams {
  final CardEntity card;

  AddCardParams(this.card);
}

final class UpdateCardParams {
  final CardEntity card;

  UpdateCardParams(this.card);
}

final class DeleteCardParams {
  final String id;

  DeleteCardParams(this.id);
}
