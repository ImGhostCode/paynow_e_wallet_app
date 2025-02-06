import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';
import 'package:paynow_e_wallet_app/core/router/app_route_enum.dart';
import 'package:paynow_e_wallet_app/core/styles/app_colors.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/image_constants.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:paynow_e_wallet_app/features/card/business/entities/card_entity.dart';
import 'package:paynow_e_wallet_app/features/card/presentation/bloc/card_bloc.dart';
import 'package:paynow_e_wallet_app/features/card/presentation/bloc/card_event.dart';
import 'package:paynow_e_wallet_app/features/card/presentation/bloc/card_state.dart';
import 'package:paynow_e_wallet_app/features/card/presentation/pages/add_card_page.dart';

class MyCardsPage extends StatefulWidget {
  const MyCardsPage({super.key});

  @override
  State<MyCardsPage> createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage> {
  int _currentCard = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  DateTime? _expiryDate;
  @override
  void initState() {
    super.initState();
    final user = context.read<AuthBloc>().state.userEntity;
    BlocProvider.of<CardBloc>(context).add(GetCardEvent(userId: user!.id!));
  }

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
        title: const Text('My Cards'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: context.read<CardBloc>().state is CardLoading
                  ? null
                  : () {
                      if (context.read<CardBloc>().state.cards.length >= 3) {
                        Helper.showSnackBar(
                            message: 'You can only add up to 3 cards');
                        return;
                      }
                      Navigator.pushNamed(
                          context, AppRouteEnum.addCardPage.name);
                    },
              icon: SvgPicture.asset(
                ImageConstants.add,
                color: AppColors.primaryColor,
                height: 24.w,
                width: 24.w,
              ))
        ],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(2.h), child: const Divider()),
      ),
      body: BlocConsumer<CardBloc, CardState>(listener: (context, state) {
        if (state is CardUpdated) {
          Helper.showSnackBar(
              message: 'Card updated successfully', isSuccess: true);
          context.read<CardBloc>().add(GetCardEvent(
              userId: context.read<AuthBloc>().state.userEntity!.id!));
          _cardHolderNameController.clear();
          _cardNumberController.clear();
          _cvvController.clear();
          _expiryDateController.clear();
          _expiryDate = null;
        }

        if (state is CardDeleted) {
          _currentCard = 0;
          Helper.showSnackBar(
              message: 'Card deleted successfully', isSuccess: true);
          context.read<CardBloc>().add(GetCardEvent(
              userId: context.read<AuthBloc>().state.userEntity!.id!));
          _cardHolderNameController.clear();
          _cardNumberController.clear();
          _cvvController.clear();
          _expiryDateController.clear();
          _expiryDate = null;
        }

        if (state is CardUpdatingError) {
          Helper.showSnackBar(message: state.message);
        }

        if (state is CardDeletingError) {
          Helper.showSnackBar(message: state.message);
        }

        if (state is CardSettedDefault) {
          Helper.showSnackBar(
              message: 'Card updated successfully', isSuccess: true);
          context.read<CardBloc>().add(GetCardEvent(
              userId: context.read<AuthBloc>().state.userEntity!.id!));
        }

        if (state is CardSettingDefaultError) {
          Helper.showSnackBar(message: state.message);
        }
      }, builder: (context, state) {
        if (state is CardLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is CardLoadingError) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is CardLoaded && state.cards.isEmpty) {
          return const Center(child: Text('No card found'));
        }
        if (state is CardLoaded) {
          return SizedBox(
            height: 1.sh,
            child: Stack(
              children: [
                SingleChildScrollView(
                    child: Column(children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  CarouselSlider(
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentCard = index;
                        });
                      },
                      height: 175.0.w,
                      enableInfiniteScroll: false,
                    ),
                    items: state.cards.map((i) {
                      return CardItem(data: i);
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: state.cards.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () =>
                            _carouselController.animateToPage(entry.key),
                        child: Container(
                          width: _currentCard == entry.key ? 8.0.w : 6.w,
                          height: _currentCard == entry.key ? 8.0.w : 6.w,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0.w, horizontal: 2.w),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentCard == entry.key
                                  ? AppColors.primaryColor
                                  : const Color(0xFF8FA1B4)),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 20.h,
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
                            ),
                            SizedBox(height: 15.h),
                            const Text('Card Number'),
                            SizedBox(height: 5.h),
                            TextFormField(
                              controller: _cardNumberController,
                              decoration: const InputDecoration(
                                  hintText: 'Enter card number'),
                              validator: (value) {
                                if (value == null) return null;
                                if (value.isNotEmpty &&
                                    int.tryParse(value) == null) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('cvv\\cvc'),
                                    SizedBox(height: 5.h),
                                    TextFormField(
                                      controller: _cvvController,
                                      decoration: const InputDecoration(
                                          hintText: '123'),
                                      validator: (value) {
                                        if (value == null) return null;
                                        if (value.isNotEmpty &&
                                            int.tryParse(value) == null) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Exp.Date'),
                                    SizedBox(height: 5.h),
                                    TextFormField(
                                      controller: _expiryDateController,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                onSelectExpDate(context,
                                                    (value) {
                                                  setState(() {
                                                    _expiryDate = value;
                                                    _expiryDateController.text =
                                                        DateFormat('MM\\yy')
                                                            .format(value);
                                                  });
                                                });
                                              },
                                              icon: const Icon(
                                                  Icons.calendar_today)),
                                          hintText: '20\\20'),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Default Card'),
                                Switch(
                                    value:
                                        state.cards[_currentCard].defaultCard,
                                    onChanged: state.cards[_currentCard]
                                                    .defaultCard ==
                                                true ||
                                            state is CardSettingDefault
                                        ? null
                                        : (value) {
                                            // TODO: Implement set default card
                                            context.read<CardBloc>().add(
                                                SetDefaultCardEvent(
                                                    cards: state.cards,
                                                    card: state
                                                        .cards[_currentCard]));
                                          })
                              ],
                            )
                          ],
                        )),
                  ),
                ])),
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
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50.h,
                            child: ElevatedButton(
                                onPressed: state is CardUpdating ||
                                        state is CardDeleting
                                    ? null
                                    : _handleUpdateCard,
                                child: const Text('Save changes')),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SizedBox(
                          height: 50.h,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.red),
                              onPressed:
                                  state is CardUpdating || state is CardDeleting
                                      ? null
                                      : () => _handleDeleteCard(
                                          state.cards[_currentCard].id!),
                              child: SvgPicture.asset(
                                ImageConstants.remove,
                                height: 24.w,
                                width: 24.w,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }

  _handleDeleteCard(String id) async {
    final bool? isAccepted = await _onTapDeleteCard(context);
    if (isAccepted == null || !isAccepted) {
      return;
    }
    context.read<CardBloc>().add(DeleteCardEvent(id: id));
  }

  Future<bool?> _onTapDeleteCard(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(24.w),
          content: Container(
            color: AppColors.white,
            width: 396.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  ImageConstants.removeIllustration,
                  height: 180.w,
                  width: 240.w,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'Are you sure to remove this card?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50.h,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                // padding: EdgeInsets.symmetric(
                                //     vertical: 16.w),
                                foregroundColor: AppColors.primaryColor),
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text('Cancel')),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50.h,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.red),
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: const Text('Remove')),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleUpdateCard() {
    if (_formKey.currentState!.validate()) {
      final card = context.read<CardBloc>().state.cards[_currentCard];
      final updatedCard = card.copyWith(
          cardHolderName: _cardHolderNameController.text.isEmpty
              ? null
              : _cardHolderNameController.text,
          cardNumber: _cardNumberController.text.isEmpty
              ? null
              : _cardNumberController.text,
          cvv: _cvvController.text.isEmpty
              ? null
              : int.parse(_cvvController.text),
          expiryDate: _expiryDate);
      context.read<CardBloc>().add(UpdateCardEvent(card: updatedCard));
    }
  }
}

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.data,
  });
  final CardEntity data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          gradient: const LinearGradient(colors: [
            Color(0xFF1A87DD),
            Color(0xFF45A7F5),
          ])),
      child: Stack(
        children: [
          Positioned(
              left: MediaQuery.of(context).size.width / 4,
              bottom: 0,
              child: Opacity(
                opacity: 0.1,
                child: SvgPicture.asset(
                  ImageConstants.visaLogo,
                  height: 150.w,
                  width: 400.w,
                ),
              )),
          Positioned.fill(
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(
                        ImageConstants.visaLogo,
                        height: 12.w,
                        width: 32.w,
                        color: Colors.white,
                      ),
                    ),
                    SvgPicture.asset(
                      ImageConstants.chipset,
                      height: 25.w,
                      width: 35.w,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      formatCardNumber(data.cardNumber),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cardholder',
                              style: TextStyle(
                                  fontSize: 10.sp, color: Colors.white),
                            ),
                            Text(
                              data.cardHolderName,
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.white),
                            )
                          ],
                        )),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Exp. Date',
                              style: TextStyle(
                                  fontSize: 10.sp, color: Colors.white),
                            ),
                            Text(
                              DateFormat.yM().format(data.expiryDate),
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.white),
                            )
                          ],
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'Balance: \$${data.balance}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  String formatCardNumber(String cardNumber) {
    String output = cardNumber.replaceAllMapped(
        RegExp(r".{1,4}"), (match) => "${match.group(0)} ");
    output = output.trim(); // Remove the trailing space
    return output;
  }
}
