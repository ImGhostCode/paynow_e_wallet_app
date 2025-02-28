enum TransactionType { send, request }

enum TransactionStatus { pending, completed, canceled }

enum Collection {
  users,
  transactions,
  cards,
  friendRequests,
  notifications,
}

enum ContactStatus { none, sent, pending, accepted, rejected }

enum NotificationType { friendRequest, transaction }
