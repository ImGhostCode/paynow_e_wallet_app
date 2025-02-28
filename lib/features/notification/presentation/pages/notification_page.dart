import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notification'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.r),
            child: Column(
              children: [
                FriendRequestItem(
                  onAccept: () {},
                  onDecline: () {},
                ),
              ],
            ),
          ),
        ));
  }
}

class FriendRequestItem extends StatelessWidget {
  const FriendRequestItem({
    super.key,
    required this.onAccept,
    required this.onDecline,
  });
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text.rich(
        TextSpan(
          text: 'John Doe',
          style: TextStyle(fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: ' sent you a friend request',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: const Text('test@gmail.com\n2 hours ago'),
      leading: CircleAvatar(
        radius: 25.r,
        backgroundImage: const AssetImage(ImageConstants.defaultUser),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.green),
            onPressed: onAccept,
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: onDecline,
          ),
        ],
      ),
    );
  }
}
