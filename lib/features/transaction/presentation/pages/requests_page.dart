import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/enum.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:paynow_e_wallet_app/features/transaction/data/models/transaction_model.dart';

class RequestsPage extends StatelessWidget {
  RequestsPage({super.key});
  final List<TransactionModel> _requests = [
    TransactionModel(
        id: '1',
        senderId: '1',
        receiverId: '2',
        amount: 12.5,
        status: TransactionStatus.completed.name,
        timestamp: DateTime.now(),
        note: ''),
    TransactionModel(
      id: '2',
      senderId: '1',
      receiverId: '2',
      amount: 12.5,
      status: TransactionStatus.completed.name,
      timestamp: DateTime.now(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.h,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 24.w,
              )),
          title: const Text('Requests'),
          centerTitle: true,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(2.h), child: const Divider()),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.r),
            child: Column(
              children: [
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.bgGray,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Total Amounts:',
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('158\$',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.secondaryColor)),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                SizedBox(
                  height: 500,
                  child: GroupedListView<TransactionModel, String>(
                    // shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    elements: _requests,
                    groupBy: (element) => element.timestamp.toString(),
                    groupSeparatorBuilder: (String groupByValue) => Text(
                        DateFormat.yMMMM('en_US')
                            .format(DateTime.parse(groupByValue)),
                        style: Theme.of(context).textTheme.bodyMedium),
                    itemBuilder: (context, TransactionModel element) =>
                        ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Hiba Saleh',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      minTileHeight: 10.h,
                      horizontalTitleGap: 5.w,
                      subtitle: Text(
                        '-\$${element.amount.toString()}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.gray,
                            ),
                      ),
                      leading: Image.asset(
                        ImageConstants.profilePicture1,
                        height: 40.w,
                        width: 40.w,
                      ),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.all(4.w),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              ImageConstants.send,
                              height: 24.w,
                              width: 24.w,
                            ),
                            const Text('Send'),
                          ],
                        ),
                      ),
                      minLeadingWidth: 40.w,
                    ),
                    // itemComparator: (item1, item2) =>
                    //     item1['name'].compareTo(item2['name']), // optional
                    // useStickyGroupSeparators: true, // optional
                    // floatingHeader: true, // optional
                    order: GroupedListOrder.ASC, // optional
                    // optional
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
            width: 375.w,
            padding: EdgeInsets.all(12.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5.r,
                  offset: const Offset(0, 0),
                )
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r)),
            ),
            child: SizedBox(
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Container(
                          color: AppColors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                ImageConstants.sentIllustration,
                                height: 180.w,
                                width: 240.w,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                'The amount has been requested successfully!',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              SizedBox(
                                height: 50.h,
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Ok, Thanks!')),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.zero,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      ImageConstants.send,
                      height: 24.w,
                      width: 24.w,
                    ),
                    const Text('Send All Payments'),
                  ],
                ),
              ),
            )));
  }
}
