import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:paynow_e_wallet_app/core/utils/injections.dart';
import 'package:paynow_e_wallet_app/features/auth/business/usecases/get_user_usecase.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/entities/transaction_entity.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_event.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_state.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(GetRequestsEvent(
        userId: context.read<AuthBloc>().state.userEntity!.id!));
  }

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
        body: BlocConsumer<TransactionBloc, TransactionState>(
            buildWhen: (previous, current) {
          if (current is LoadingRequests ||
              current is RequestsLoadingError ||
              current is RequestsLoaded) {
            return true;
          }
          return false;
        }, listener: (context, state) {
          if (state is RequestAccepted) {
            Helper.showSnackBar(message: 'Request accepted', isSuccess: true);
            context.read<TransactionBloc>().add(GetRequestsEvent(
                userId: context.read<AuthBloc>().state.userEntity!.id!));
            // Send notification to sender
            // reload balance
          }

          if (state is RequestAcceptingError) {
            Helper.showSnackBar(message: state.message);
          }

          if (state is AllRequestsAccepted) {
            Helper.showSnackBar(
                message: 'All requests accepted', isSuccess: true);
            context.read<TransactionBloc>().add(GetRequestsEvent(
                userId: context.read<AuthBloc>().state.userEntity!.id!));
            // Send notification to sender
            // reload balance
          }

          if (state is AllRequestsAcceptingError) {
            Helper.showSnackBar(message: state.message);
          }
        }, builder: (context, state) {
          if (state is LoadingRequests) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RequestsLoadingError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is RequestsLoaded && state.requests.isEmpty) {
            return const Center(
              child: Text('No requests found'),
            );
          }
          if (state is RequestsLoaded) {
            double total = 0;
            for (var element in state.requests) {
              total += element.amount;
            }
            return SingleChildScrollView(
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
                          Text('Total Amounts: ',
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text('${total.toStringAsFixed(1)}\$',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.secondaryColor)),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(
                      height: 500,
                      child: GroupedListView<TransactionEntity, String>(
                        // shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        elements: state.requests,
                        groupBy: (element) => element.timestamp.toString(),
                        groupSeparatorBuilder: (String groupByValue) => Text(
                            DateFormat.yMMMd('en_US')
                                .format(DateTime.parse(groupByValue)),
                            style: Theme.of(context).textTheme.bodyMedium),
                        itemBuilder: (context, TransactionEntity element) =>
                            BlocProvider(
                                create: (context) => AuthBloc(
                                      getUserUsecase: sl<GetUserUsecase>(),
                                    )..add(GetUserEvent(id: element.senderId)),
                                child: BlocBuilder<AuthBloc, AuthState>(
                                    builder: (context, state) {
                                  if (state is IsLoadingUser) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
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
                                      title: Text.rich(
                                        TextSpan(
                                          text:
                                              state.userEntity?.name != null &&
                                                      state.userEntity!.name
                                                          .isNotEmpty
                                                  ? state.userEntity!.name
                                                  : element.senderId,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                          children: [
                                            TextSpan(
                                                text: ' requested ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium),
                                            TextSpan(
                                              text:
                                                  '\$${element.amount.toString()}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .secondaryColor),
                                            ),
                                          ],
                                        ),
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
                                      leading: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child:
                                            state.userEntity!.avatar.isNotEmpty
                                                ? Image.network(
                                                    state.userEntity!.avatar,
                                                    fit: BoxFit.cover,
                                                    height: 40.w,
                                                    width: 40.w,
                                                  )
                                                : Image.asset(
                                                    ImageConstants.defaultUser,
                                                    height: 40.w,
                                                    width: 40.w,
                                                  ),
                                      ),
                                      trailing: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          foregroundColor: Colors.black,
                                          padding: EdgeInsets.all(4.w),
                                        ),
                                        onPressed: context
                                                        .watch<TransactionBloc>()
                                                        .state
                                                    is AcceptingRequest ||
                                                context
                                                        .watch<TransactionBloc>()
                                                        .state
                                                    is AcceptingAllRequests
                                            ? null
                                            : () async {
                                                final bool? isConfirm =
                                                    await _showConfirmDialog(
                                                        context, state);

                                                if (isConfirm == null ||
                                                    !isConfirm) {
                                                  return;
                                                }

                                                context
                                                    .read<TransactionBloc>()
                                                    .add(AcceptRequestEvent(
                                                        transaction: element));
                                              },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                    );
                                  }
                                  return const SizedBox();
                                })),
                        // itemComparator: (item1, item2) =>
                        //     item1['name'].compareTo(item2['name']), // optional
                        // useStickyGroupSeparators: true, // optional
                        // floatingHeader: true, // optional
                        order: GroupedListOrder.DESC, // optional
                        // optional
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        }),
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
                onPressed:
                    context.watch<TransactionBloc>().state is RequestsLoaded &&
                            (context.watch<TransactionBloc>().state
                                    as RequestsLoaded)
                                .requests
                                .isNotEmpty &&
                            context.watch<TransactionBloc>().state
                                is! AcceptingRequest &&
                            context.watch<TransactionBloc>().state
                                is! AcceptingAllRequests
                        ? () async {
                            final bool? isConfirm =
                                await _showConfirmDialog(context, null);

                            if (isConfirm == null || !isConfirm) {
                              return;
                            }

                            context.read<TransactionBloc>().add(
                                AcceptAllRequestsEvent(
                                    transactions: (context
                                            .read<TransactionBloc>()
                                            .state as RequestsLoaded)
                                        .requests));
                          }
                        : null,
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

  Future<bool?> _showConfirmDialog(BuildContext context, LoadedUser? state) {
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: Text.rich(TextSpan(
                text:
                    'Are you sure to send ${state == null ? 'all ' : ''}the payment to ',
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  state == null
                      ? const TextSpan(text: 'your friends')
                      : TextSpan(
                          text: state.userEntity!.name.isNotEmpty
                              ? state.userEntity!.name
                              : state.userEntity!.id,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                  const TextSpan(text: '?')
                ])),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes')),
            ],
          );
        });
  }
}

// Accept => Add transaction => send notification to sender
// Reject => send notification to sender
