import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/core/utils/injections.dart';
import 'package:paynow_e_wallet_app/features/auth/business/entities/user_entity.dart';
import 'package:paynow_e_wallet_app/features/auth/business/usecases/get_user_usecase.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/entities/transaction_entity.dart';
import 'package:intl/intl.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_event.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_state.dart';

enum TransactionView { income, expense }

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key, required this.user});
  final UserEntity user;
  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  TransactionView transactionView = TransactionView.expense;
  final Map<String, List<TransactionEntity>> _groupedIncomes = {};
  final Map<String, List<TransactionEntity>> _groupedExpenses = {};

  @override
  void initState() {
    context
        .read<TransactionBloc>()
        .add(GetTransactionEvent(userId: widget.user.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(
              50.h,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.r),
              child: Container(
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
                          if (transactionView == TransactionView.income) {
                            return;
                          }
                          context.read<TransactionBloc>().add(
                              GetTransactionEvent(userId: widget.user.id!));
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
                          if (transactionView == TransactionView.expense) {
                            return;
                          }
                          context.read<TransactionBloc>().add(
                              GetTransactionEvent(userId: widget.user.id!));
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
            ),
          ),
        ),
        body: BlocConsumer<TransactionBloc, TransactionState>(
            listener: (context, state) {
          if (state is TransactionLoaded) {
            _groupTransactions(state.transactions);
          }
        }, builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TransactionLoadingError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is TransactionLoaded && state.transactions.isEmpty) {
            return const Center(
              child: Text('No transactions yet'),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.r),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 15.h),
                IndexedStack(
                    index: transactionView == TransactionView.income ? 0 : 1,
                    // physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _groupedIncomes.isEmpty
                          ? const Center(
                              child: Text('No transactions yet'),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: _groupedIncomes.length,
                              itemBuilder: (context, index) {
                                final key =
                                    _groupedIncomes.keys.elementAt(index);
                                final value = _groupedIncomes[key];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                      child: Text(
                                        DateFormat.yMMMd('en_US')
                                            .format(DateTime.parse(key)),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                    for (var element in value!)
                                      BlocProvider(
                                        create: (context) => AuthBloc(
                                          getUserUsecase: sl<GetUserUsecase>(),
                                        )..add(
                                            GetUserEvent(id: element.senderId)),
                                        child: BlocBuilder<AuthBloc, AuthState>(
                                            builder: (context, state) {
                                          if (state is IsLoadingUser) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          if (state is ErrorLoadingUser) {
                                            return Center(
                                              child: Text(state.error),
                                            );
                                          }
                                          if (state is LoadedUser) {
                                            return ListTile(
                                              minTileHeight: 60.h,
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(
                                                state.userEntity?.name !=
                                                            null &&
                                                        state.userEntity!.name
                                                            .isNotEmpty
                                                    ? state.userEntity!.name
                                                    : element.senderId,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              horizontalTitleGap: 5.w,
                                              subtitle: Text(
                                                '${state.userEntity!.email} at ${DateFormat.jm('en_US').format(DateTime.parse(element.timestamp.toString()))}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: AppColors.gray,
                                                    ),
                                              ),
                                              trailing: Text(
                                                '+\$${element.amount.toString()}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                              leading: Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: state.userEntity!.avatar
                                                        .isNotEmpty
                                                    ? Image.network(
                                                        state
                                                            .userEntity!.avatar,
                                                        fit: BoxFit.cover,
                                                        height: 40.w,
                                                        width: 40.w,
                                                      )
                                                    : Image.asset(
                                                        ImageConstants
                                                            .defaultUser,
                                                        height: 40.w,
                                                        width: 40.w,
                                                      ),
                                              ),
                                            );
                                          }
                                          return const SizedBox();
                                        }),
                                      ),
                                  ],
                                );
                              },
                            ),
                      _groupedExpenses.isEmpty
                          ? const Center(
                              child: Text('No transactions yet'),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: _groupedExpenses.length,
                              itemBuilder: (context, index) {
                                final key =
                                    _groupedExpenses.keys.elementAt(index);
                                final value = _groupedExpenses[key];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                      child: Text(
                                        DateFormat.yMMMd('en_US')
                                            .format(DateTime.parse(key)),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                    for (var element in value!)
                                      BlocProvider(
                                        create: (context) => AuthBloc(
                                          getUserUsecase: sl<GetUserUsecase>(),
                                        )..add(GetUserEvent(
                                            id: element.receiverId)),
                                        child: BlocBuilder<AuthBloc, AuthState>(
                                            builder: (context, state) {
                                          if (state is IsLoadingUser) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          if (state is ErrorLoadingUser) {
                                            return Center(
                                              child: Text(state.error),
                                            );
                                          }
                                          if (state is LoadedUser) {
                                            return ListTile(
                                              minTileHeight: 60.h,
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(
                                                state.userEntity?.name !=
                                                            null &&
                                                        state.userEntity!.name
                                                            .isNotEmpty
                                                    ? state.userEntity!.name
                                                    : element.receiverId,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              horizontalTitleGap: 5.w,
                                              subtitle: Text(
                                                '${state.userEntity!.email} at ${DateFormat.jm('en_US').format(DateTime.parse(element.timestamp.toString()))}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: AppColors.gray,
                                                    ),
                                              ),
                                              trailing: Text(
                                                '-\$${element.amount.toString()}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                              leading: Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: state.userEntity!.avatar
                                                        .isNotEmpty
                                                    ? Image.network(
                                                        state
                                                            .userEntity!.avatar,
                                                        fit: BoxFit.cover,
                                                        height: 40.w,
                                                        width: 40.w,
                                                      )
                                                    : Image.asset(
                                                        ImageConstants
                                                            .defaultUser,
                                                        height: 40.w,
                                                        width: 40.w,
                                                      ),
                                              ),
                                            );
                                          }
                                          return const SizedBox();
                                        }),
                                      ),
                                  ],
                                );
                              },
                            ),
                    ]),
              ],
            ),
          );
        }));
  }

  void _groupTransactions(List<TransactionEntity> transactions) {
    // _groupedTransactions.clear();
    _groupedIncomes.clear();
    _groupedExpenses.clear();

    for (var element in transactions) {
      if (element.senderId == widget.user.id) {
        if (_groupedExpenses
            .containsKey(element.timestamp.toString().substring(0, 10))) {
          _groupedExpenses[element.timestamp.toString().substring(0, 10)]!
              .add(element);
        } else {
          _groupedExpenses[element.timestamp.toString().substring(0, 10)] = [
            element
          ];
        }
      } else {
        if (_groupedIncomes
            .containsKey(element.timestamp.toString().substring(0, 10))) {
          _groupedIncomes[element.timestamp.toString().substring(0, 10)]!
              .add(element);
        } else {
          _groupedIncomes[element.timestamp.toString().substring(0, 10)] = [
            element
          ];
        }
      }
    }
  }
}
