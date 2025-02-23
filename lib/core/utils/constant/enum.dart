enum TransactionType { send, request }

enum TransactionStatus { pending, completed, canceled }

enum Collection {
  users,
  transactions,
  cards,
  friendRequests,
}

enum ContactStatus { none, sent, pending, accepted, rejected }
