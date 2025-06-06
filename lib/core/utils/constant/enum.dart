enum TransactionType { send, request }

enum TransactionStatus { pending, completed, canceled, failed }

enum TransactionAction { send, request }

enum Collection {
  users,
  transactions,
  cards,
  friendRequests,
  notifications,
}

enum ContactStatus { none, sent, pending, accepted, rejected }

enum NotificationType {
  friendRequest,
  receivedMoney,
  requestMoney,
  acceptedMoneyRequest
}
