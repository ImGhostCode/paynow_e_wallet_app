import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paynow_e_wallet_app/core/network/error/exceptions.dart';
import 'package:paynow_e_wallet_app/core/params/contact_params.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/enum.dart';
import 'package:paynow_e_wallet_app/features/auth/data/models/user_model.dart';
import 'package:paynow_e_wallet_app/features/contact/data/data_sources/contact_remote_data_source.dart';
import 'package:paynow_e_wallet_app/features/contact/data/models/friend_request_model.dart';

class ContactRemoteDataSourceImpl extends ContactRemoteDataSource {
  final FirebaseFirestore _firestore;

  ContactRemoteDataSourceImpl(this._firestore);

  @override
  Future<void> cancelFriendRequest(CancelFrParams params) async {
    try {
      final senderId = FirebaseAuth.instance.currentUser!.uid;

      final requestRef = _firestore
          .collection(Collection.friendRequests.name)
          .where('senderId', isEqualTo: senderId)
          .where('receiverId', isEqualTo: params.receiverId)
          .where('status', isEqualTo: FriendRequestStatus.pending.name);

      final request = await requestRef.get();

      if (request.docs.isNotEmpty) {
        await request.docs.first.reference.delete();
      } else {
        throw ServerException("Friend request not found.", null);
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<List<FriendRequestModel>> getFriendRequests(
      GetFriendRequestsParams params) async {
    try {
      final result = await _firestore
          .collection(Collection.friendRequests.name)
          .where('receiverId', isEqualTo: params.userId)
          .where('status', isEqualTo: FriendRequestStatus.pending.name)
          .get();

      return result.docs
          .map((e) => FriendRequestModel.fromFirestore(e))
          .toList();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<List<String>> getFriends(GetFriendsParams params) async {
    try {
      final userRef =
          _firestore.collection(Collection.users.name).doc(params.userId);

      final user = await userRef.get();

      if (!user.exists) {
        throw ServerException("User not found.", null);
      }

      final friends = user.get('friends') as List<dynamic>;

      return friends.map((e) => e.toString()).toList();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<void> respondToFriendRequest(ResponseToFrParams params) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final requestRef = _firestore
          .collection(Collection.friendRequests.name)
          .doc(params.requestId);

      if (params.accept) {
        // Update request status
        await requestRef.update({'status': FriendRequestStatus.accepted.name});

        // Add each other as friends
        final userRef =
            _firestore.collection(Collection.users.name).doc(userId);
        final senderRef =
            _firestore.collection(Collection.users.name).doc(params.senderId);

        await userRef.update({
          'friends': FieldValue.arrayUnion([params.senderId])
        });

        await senderRef.update({
          'friends': FieldValue.arrayUnion([userId])
        });

        // print("Friend request accepted.");
      } else {
        await requestRef.update({'status': FriendRequestStatus.rejected.name});
        // print("Friend request rejected.");
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<void> sendFriendRequest(SendFriendRequestParams params) async {
    try {
      final senderId = FirebaseAuth.instance.currentUser!.uid;

      final requestRef = _firestore.collection(Collection.friendRequests.name);

      // Check if request already exists
      final existingRequest = await requestRef
          .where('senderId', isEqualTo: senderId)
          .where('receiverId', isEqualTo: params.receiverId)
          .where('status', isEqualTo: FriendRequestStatus.pending.name)
          .get();

      if (existingRequest.docs.isNotEmpty) {
        throw ServerException("Friend request already sent.", null);
      }

      await requestRef.add(FriendRequestModel(
              senderId: senderId,
              receiverId: params.receiverId,
              status: FriendRequestStatus.pending.name,
              timestamp: DateTime.now())
          .toFirestore());
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<void> unfriend(UnfriendParams params) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      final userRef = _firestore.collection(Collection.users.name).doc(userId);

      final user = await userRef.get();

      if (!user.exists) {
        throw ServerException("User not found.", null);
      }

      final friends = user.get('friends') as List<dynamic>;

      if (!friends.contains(params.friendId)) {
        throw ServerException("Friend not found.", null);
      }

      await userRef.update({
        'friends': FieldValue.arrayRemove([params.friendId])
      });

      final friendRef =
          _firestore.collection(Collection.users.name).doc(params.friendId);

      final friend = await friendRef.get();

      if (!friend.exists) {
        throw ServerException("Friend not found.", null);
      }

      final friendFriends = friend.get('friends') as List<dynamic>;

      if (!friendFriends.contains(userId)) {
        throw ServerException("User not found in friend's friend list.", null);
      }

      await friendRef.update({
        'friends': FieldValue.arrayRemove([userId])
      });
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<List<UserModel>> getUserByEmail(GetUserByEmailParams params) async {
    try {
      final result = await _firestore
          .collection(Collection.users.name)
          .where('email', isEqualTo: params.email)
          .get();

      return result.docs.map((e) => UserModel.fromFirestore(e)).toList();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? '', e.code);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}
