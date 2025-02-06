import 'package:equatable/equatable.dart';
import 'package:paynow_e_wallet_app/features/card/business/entities/card_entity.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}

class GetCardEvent extends CardEvent {
  final String userId;

  const GetCardEvent({required this.userId});
}

class AddCardEvent extends CardEvent {
  final CardEntity card;

  const AddCardEvent({required this.card});
}

class UpdateCardEvent extends CardEvent {
  final CardEntity card;

  const UpdateCardEvent({required this.card});
}

class SetDefaultCardEvent extends CardEvent {
  final List<CardEntity> cards;
  final CardEntity card;

  const SetDefaultCardEvent({required this.card, required this.cards});
}

class DeleteCardEvent extends CardEvent {
  final String id;

  const DeleteCardEvent({required this.id});
}
