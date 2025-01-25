import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:paynow_e_wallet_app/features/card/business/entities/card_entity.dart';
import 'package:paynow_e_wallet_app/features/card/presentation/bloc/card_bloc.dart';
import 'package:paynow_e_wallet_app/features/card/presentation/bloc/card_event.dart';
import 'package:paynow_e_wallet_app/features/card/presentation/bloc/card_state.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  DateTime? _expiryDate;

  @override
  void dispose() {
    _cardHolderNameController.dispose();
    _cardNumberController.dispose();
    _cvvController.dispose();
    _expiryDateController.dispose();
    super.dispose();
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
        title: const Text('Add Card'),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(2.h), child: const Divider()),
      ),
      body: BlocConsumer<CardBloc, CardState>(listener: (context, state) {
        if (state is CardAdded) {
          Helper.showSnackBar(
              message: 'Card added successfully', isSuccess: true);
          Navigator.pop(context);
          context.read<CardBloc>().add(GetCardEvent(
              userId: context.read<AuthBloc>().state.userEntity!.id!));
        }

        if (state is CardAddingError) {
          Helper.showSnackBar(message: state.message);
        }
      }, builder: (context, state) {
        return SizedBox(
          height: 1.sh,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Cardholder Name'),
                              SizedBox(height: 5.h),
                              TextFormField(
                                controller: _cardHolderNameController,
                                decoration: const InputDecoration(
                                    hintText:
                                        'Enter your name as written on card'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 15.h),
                              const Text('Card Number'),
                              SizedBox(height: 5.h),
                              TextFormField(
                                controller: _cardNumberController,
                                decoration: const InputDecoration(
                                    hintText: 'Enter card number'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter card number';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Please enter a valid card number';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 15.h),
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('cvv\\cvc'),
                                      SizedBox(height: 5.h),
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: _cvvController,
                                        decoration: const InputDecoration(
                                            hintText: '123'),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter cvv\\cvc';
                                          }
                                          if (int.tryParse(value) == null) {
                                            return 'Please enter a valid cvv\\cvc';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  )),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Exp.Date'),
                                      SizedBox(height: 5.h),
                                      TextFormField(
                                        controller: _expiryDateController,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  onSelectExpDate(context,
                                                      (value) {
                                                    setState(() {
                                                      _expiryDate = value;
                                                      _expiryDateController
                                                              .text =
                                                          DateFormat('MM\\yy')
                                                              .format(value);
                                                    });
                                                  });
                                                },
                                                icon: const Icon(
                                                    Icons.calendar_today)),
                                            hintText: '20\\20'),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter expiry date';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ))
                                ],
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
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
                        onPressed: state is CardAdding ? null : _handleAddCard,
                        child: const Text('Submit Card')),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _handleAddCard() {
    if (_formKey.currentState!.validate()) {
      context.read<CardBloc>().add(AddCardEvent(
          card: CardEntity(
              ownerId: context.read<AuthBloc>().state.userEntity!.id!,
              cardHolderName: _cardHolderNameController.text,
              cardNumber: _cardNumberController.text,
              cvv: int.parse(_cvvController.text),
              expiryDate: _expiryDate!,
              balance: 0)));
    }
  }
}

void onSelectExpDate(BuildContext context, Function(DateTime) onSelected) {
  showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2050))
      .then((value) {
    if (value != null) {
      onSelected(value);
    }
  });
}
