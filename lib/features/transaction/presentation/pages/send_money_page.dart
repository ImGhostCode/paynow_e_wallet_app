import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/app_constants.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/enum.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:paynow_e_wallet_app/features/auth/business/entities/user_entity.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:paynow_e_wallet_app/features/card/presentation/bloc/card_bloc.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/bloc/contact_bloc.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/bloc/contact_event.dart';
import 'package:paynow_e_wallet_app/features/contact/presentation/bloc/contact_state.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/entities/transaction_entity.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_event.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_state.dart';

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({super.key});

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  late UserEntity? args;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  UserEntity? _selectedContact;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      args = ModalRoute.of(context)!.settings.arguments as UserEntity?;
      if (args != null) {
        _selectedContact = args;
        setState(() {});
      }
    });
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
          title: const Text('Send Money'),
          centerTitle: true,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(2.h), child: const Divider()),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.r),
            child: Column(
              children: [
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  leading: Container(
                    width: 60.w,
                    height: 60.w,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: (_selectedContact != null &&
                            _selectedContact!.avatar.isNotEmpty)
                        ? Image.network(
                            _selectedContact!.avatar,
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            ImageConstants.defaultUser,
                            fit: BoxFit.contain,
                          ),
                  ),
                  title: _selectedContact != null &&
                          _selectedContact!.name.isNotEmpty
                      ? Text(_selectedContact!.name)
                      : (_selectedContact != null &&
                              _selectedContact!.email.isNotEmpty)
                          ? Text(_selectedContact!.email)
                          : const Text('Choose a contact'),
                  onTap: () => handleSelectContact(
                    context: context,
                    onSelected: (value) {
                      setState(() {
                        _selectedContact = value;
                      });
                    },
                  ),
                  subtitle: _selectedContact != null &&
                          _selectedContact!.email.isNotEmpty
                      ? Text(_selectedContact!.email)
                      : null,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Payment Amount'),
                        TextFormField(
                          autofocus: true,
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: AppColors.secondaryColor),
                          decoration: InputDecoration(
                            hintText: 'Enter amount',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)),
                              borderSide: const BorderSide(
                                  color: AppColors.secondaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)),
                              borderSide: const BorderSide(
                                  color: AppColors.secondaryColor),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter amount';
                            }

                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid amount';
                            }

                            if (double.parse(value) <= minAmount) {
                              return 'Amount must be greater than \$${minAmount.toInt()}';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Balance: \$${context.watch<CardBloc>().state.totalBalance.toStringAsFixed(1)}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.green),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        const Text('Payment note'),
                        TextFormField(
                          controller: _noteController,
                          keyboardType: TextInputType.text,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            hintText: 'Add payment note',
                          ),
                          validator: (value) {
                            return null;
                          },
                        ),
                      ],
                    ))
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
            child: SendMoneyButton(
                selectedContact: _selectedContact,
                amountController: _amountController,
                noteController: _noteController,
                formKey: _formKey)));
  }
}

class SendMoneyButton extends StatelessWidget {
  const SendMoneyButton({
    super.key,
    required UserEntity? selectedContact,
    required TextEditingController amountController,
    required TextEditingController noteController,
    required GlobalKey<FormState> formKey,
  })  : _selectedContact = selectedContact,
        _amountController = amountController,
        _noteController = noteController,
        _formKey = formKey;

  final UserEntity? _selectedContact;
  final TextEditingController _amountController;
  final TextEditingController _noteController;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: BlocConsumer<TransactionBloc, TransactionState>(
          listener: (context, state) {
        if (state is TransactionAddingError) {
          Helper.showSnackBar(message: state.message);
        }

        if (state is TransactionAdded) {
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
                        'The amount has been sent successfully!',
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
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
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
        }
      }, builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Colors.black,
          ),
          onPressed: _selectedContact == null ||
                  _amountController.text.isEmpty ||
                  state is TransactionAdding
              ? null
              : () {
                  if (_formKey.currentState!.validate()) {
                    if (context.read<CardBloc>().state.cards.isEmpty) {
                      Helper.showSnackBar(message: 'You have not added a card');
                      return;
                    }

                    if (context.read<CardBloc>().state.totalBalance <
                        double.parse(_amountController.text)) {
                      Helper.showSnackBar(message: 'Insufficient balance');
                      return;
                    }

                    context.read<TransactionBloc>().add(AddTransactionEvent(
                            transaction: TransactionEntity(
                          transactionType: TransactionType.send.name,
                          receiverId: _selectedContact!.id!,
                          senderId:
                              context.read<AuthBloc>().state.userEntity!.id!,
                          amount: double.parse(_amountController.text),
                          timestamp: DateTime.now(),
                          message: _noteController.text,
                          status: TransactionStatus.pending.name,
                        )));
                  }
                },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImageConstants.send,
                height: 24.w,
                width: 24.w,
              ),
              const Text('Send Payment'),
            ],
          ),
        );
      }),
    );
  }
}

void handleSelectContact(
    {required BuildContext context,
    required Function(dynamic) onSelected}) async {
  final result =
      await showSearch(context: context, delegate: CustomSearchDelegate());
  if (result != null) {
    onSelected(result);
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<UserEntity> items = [];

  CustomSearchDelegate();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          size: 24.w,
          color: Colors.black,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        size: 24.w,
        color: Colors.black,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    items = context.watch<ContactBloc>().state is LoadedFriends
        ? (context.watch<ContactBloc>().state as LoadedFriends).friends
        : [];
    final results = items
        .where((item) => item.email.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index].email),
          onTap: () {
            close(context, results[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    items = context.watch<ContactBloc>().state is LoadedFriends
        ? (context.watch<ContactBloc>().state as LoadedFriends).friends
        : [];
    final suggestions = items
        .where(
            (item) => item.email.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return RefreshIndicator(
      onRefresh: () {
        // _allFriends.clear();
        // _filteredFriends.clear();
        items.clear();
        context.read<ContactBloc>().add(GetFriendsEvent(
              userId: context.read<AuthBloc>().state.userEntity?.id,
            ));
        return Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 60.w,
              height: 60.w,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: suggestions[index].avatar.isNotEmpty
                  ? Image.network(
                      suggestions[index].avatar,
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      ImageConstants.defaultUser,
                      fit: BoxFit.contain,
                    ),
            ),
            title: Text(suggestions[index].name.isNotEmpty
                ? suggestions[index].name
                : suggestions[index].id!),
            subtitle: Text(suggestions[index].email,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.gray)),
            onTap: () {
              // query = suggestions[index].email;
              // showResults(context);
              return close(context, suggestions[index]);
            },
          );
        },
      ),
    );
  }
}
