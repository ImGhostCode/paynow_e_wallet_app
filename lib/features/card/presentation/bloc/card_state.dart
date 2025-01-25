import 'package:equatable/equatable.dart';
import 'package:paynow_e_wallet_app/features/card/business/entities/card_entity.dart';

abstract class CardState extends Equatable {
  final List<CardEntity> cards;

  const CardState({this.cards = const []});

  double get totalBalance {
    double total = 0;
    for (var card in cards) {
      total += card.balance;
    }
    return total;
  }

  @override
  List<Object?> get props => [cards];
}

class CardInitial extends CardState {}

class CardLoading extends CardState {}

class CardLoaded extends CardState {
  const CardLoaded({required super.cards});
}

class CardLoadingError extends CardState {
  final String message;

  const CardLoadingError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CardAdding extends CardState {}

class CardAdded extends CardState {
  final CardEntity addedCard;
  CardAdded({required this.addedCard, required List<CardEntity> currCards})
      : super(cards: [...currCards, addedCard]);
}

class CardAddingError extends CardState {
  final String message;

  const CardAddingError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CardUpdating extends CardState {}

class CardUpdatingError extends CardState {
  final String message;

  const CardUpdatingError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CardUpdated extends CardState {}

class CardDeleting extends CardState {}

class CardDeletingError extends CardState {
  final String message;

  const CardDeletingError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CardDeleted extends CardState {}
