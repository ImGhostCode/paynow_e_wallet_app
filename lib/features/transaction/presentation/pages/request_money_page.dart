import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/enum.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:paynow_e_wallet_app/features/auth/business/entities/user_entity.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:paynow_e_wallet_app/features/transaction/business/entities/transaction_entity.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_event.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/bloc/transaction_state.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/pages/send_money_page.dart';

class RequestMoneyPage extends StatefulWidget {
  const RequestMoneyPage({super.key});

  @override
  State<RequestMoneyPage> createState() => _RequestMoneyPageState();
}

class _RequestMoneyPageState extends State<RequestMoneyPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  UserEntity? _selectedContact;

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
          title: const Text('Request Money'),
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
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                        clipBehavior: Clip.antiAlias,
                        child: (_selectedContact != null &&
                                _selectedContact!.avatar.isNotEmpty)
                            ? Image.network(
                                _selectedContact!.avatar,
                                fit: BoxFit.fill,
                              )
                            : _selectedContact != null
                                ? Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.bgGray,
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      _selectedContact?.name[0] ??
                                          _selectedContact!.email[0],
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : Image.asset(
                                    ImageConstants.defaultUser,
                                    fit: BoxFit.fill,
                                  )),
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
                              .copyWith(color: AppColors.primaryColor),
                          decoration: InputDecoration(
                            hintText: 'Enter amount',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)),
                              borderSide: const BorderSide(
                                  color: AppColors.primaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)),
                              borderSide: const BorderSide(
                                  color: AppColors.primaryColor),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter amount';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid amount';
                            }

                            if (double.parse(value) <= 0) {
                              return 'Amount must be greater than 0';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {});
                          },
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
            child: RequestMoneyButton(
                selectedContact: _selectedContact,
                amountController: _amountController,
                noteController: _noteController,
                formKey: _formKey)));
  }
}

class RequestMoneyButton extends StatelessWidget {
  const RequestMoneyButton({
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
    return BlocConsumer<TransactionBloc, TransactionState>(
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
      return SizedBox(
        height: 50.h,
        child: ElevatedButton(
          onPressed: _selectedContact == null ||
                  _amountController.text.isEmpty ||
                  state is TransactionAdding
              ? null
              : () {
                  if (_formKey.currentState!.validate()) {
                    context.read<TransactionBloc>().add(AddTransactionEvent(
                            transaction: TransactionEntity(
                          transactionType: TransactionType.request.name,
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
                ImageConstants.request,
                height: 24.w,
                width: 24.w,
                color: AppColors.white,
              ),
              const Text('Request Payment'),
            ],
          ),
        ),
      );
    });
  }
}
