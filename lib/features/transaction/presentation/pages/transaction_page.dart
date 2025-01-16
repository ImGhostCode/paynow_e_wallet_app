import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/enum.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/features/transaction/data/models/transaction_model.dart';
import 'package:intl/intl.dart';

enum TransactionView { income, expense }

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  TransactionView transactionView = TransactionView.expense;
  final List<TransactionModel> _transactions = [
    TransactionModel(
        senderId: '1',
        receiverId: '2',
        amount: 12.5,
        type: TransactionType.send,
        status: TransactionStatus.completed,
        timestamp: '2024-10-01 00:00:00',
        description: ''),
    TransactionModel(
        senderId: '1',
        receiverId: '2',
        amount: 12.5,
        type: TransactionType.send,
        status: TransactionStatus.completed,
        timestamp: '2024-09-01 00:00:00',
        description: '')
  ];

  final Map<String, List<TransactionModel>> _groupedTransactions = {};

  @override
  Widget build(BuildContext context) {
    for (var element in _transactions) {
      if (_groupedTransactions.containsKey(element.timestamp)) {
        _groupedTransactions[element.timestamp]!.add(element);
      } else {
        _groupedTransactions[element.timestamp] = [element];
      }
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Transaction'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                ImageConstants.search,
                color: Theme.of(context).colorScheme.primary,
                height: 24.w,
                width: 24.w,
              ),
              onPressed: () {},
            ),
            SizedBox(width: 10.w),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.bgGray,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  padding: EdgeInsets.all(6.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50.h,
                        width: 165.w,
                        child: ElevatedButton(
                          style: transactionView == TransactionView.income
                              ? ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.zero)
                              : ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.bgGray,
                                  elevation: 0,
                                  foregroundColor: Colors.black,
                                  padding: EdgeInsets.zero),
                          onPressed: () {
                            setState(() {
                              transactionView = TransactionView.income;
                            });
                          },
                          child: const Text('Incomes'),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                        width: 165.w,
                        child: ElevatedButton(
                          style: transactionView == TransactionView.expense
                              ? ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  foregroundColor: Colors.black,
                                  padding: EdgeInsets.zero)
                              : ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: AppColors.bgGray,
                                  foregroundColor: Colors.black,
                                  padding: EdgeInsets.zero),
                          onPressed: () {
                            setState(() {
                              transactionView = TransactionView.expense;
                            });
                          },
                          child: const Text('Expenses'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                _groupedTransactions.isEmpty
                    ? const Center(
                        child: Text('No transactions yet'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _groupedTransactions.length,
                        itemBuilder: (context, index) {
                          final key =
                              _groupedTransactions.keys.elementAt(index);
                          final value = _groupedTransactions[key];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: Text(
                                  DateFormat.yMMMM('en_US')
                                      .format(DateTime.parse(key)),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              for (var element in value!)
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    'Hiba Saleh',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  horizontalTitleGap: 5.w,
                                  subtitle: Text(
                                    DateFormat.jm('en_US').format(
                                        DateTime.parse(element.timestamp)),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: AppColors.gray,
                                        ),
                                  ),
                                  trailing: Text(
                                    '${element.type == TransactionType.send ? '-' : ''}\$${element.amount.toString()}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  leading: Image.asset(
                                    ImageConstants.profilePicture1,
                                    height: 40.w,
                                    width: 40.w,
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
              ],
            ),
          ),
        ));
  }
}
