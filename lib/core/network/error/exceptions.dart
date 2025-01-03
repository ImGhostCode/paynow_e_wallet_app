/// Exception occur when server failure
class ServerException implements Exception {
  final String message;
  final String? code;

  ServerException(this.message, this.code);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    if (other is ServerException) {
      return other.message == message && other.code == code;
    }

    return false;
  }
}

// class FirebaseException implements Exception {
//   final String message;
//   final int? code;

//   FirebaseException(this.message, this.code);

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) {
//       return true;
//     }
//     if (other.runtimeType != runtimeType) {
//       return false;
//     }
//     if (other is FirebaseException) {
//       return other.message == message && other.code == code;
//     }

//     return false;
//   }
// }

/// Exception occur when call api over on time
class CancelTokenException implements Exception {
  final String message;
  final int? statusCode;

  CancelTokenException(this.message, this.statusCode);
}
