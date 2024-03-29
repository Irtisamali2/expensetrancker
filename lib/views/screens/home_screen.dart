import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_expense_tracker_app/constants/colors.dart';
import 'package:flutter_expense_tracker_app/controllers/home_controller.dart';
import 'package:flutter_expense_tracker_app/controllers/theme_controller.dart';
import 'package:flutter_expense_tracker_app/models/currency.dart';
import 'package:flutter_expense_tracker_app/views/screens/add_transaction_screen.dart';
import 'package:flutter_expense_tracker_app/views/screens/all_transactions_screen.dart';
import 'package:flutter_expense_tracker_app/views/screens/chart_screen.dart';
import 'package:flutter_expense_tracker_app/views/widgets/income_expense.dart';
import 'package:flutter_expense_tracker_app/views/widgets/placeholder_info.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

import '../../ads/internstitialads.dart';
import '../../ads/openMobAds.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController _homeController = Get.put(HomeController());
  final _themeController = Get.find<ThemeController>();
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();

  Future<void> getAdsData() async {
    AdmobHelper admobHelper = AdmobHelper();
    admobHelper.initialization();
    appOpenAdManager.loadAd();
  }

  @override
  Widget build(BuildContext context) {
    getAdsData().then((value) {
      Future.delayed(const Duration(seconds: 20), () {
        if (AppOpenAdManager.isLoaded) {
          appOpenAdManager.showAdIfAvailable(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      });
    });
    
      return Scaffold(
        // bottomNavigationBar: Obx(() => _homeController.isAdLoaded.value == true
        //     ? SizedBox(
        //         height: _homeController.bannerAd.size.height.toDouble(),
        //         width: _homeController.bannerAd.size.width.toDouble(),
        //         child: AdWidget(ad: _homeController.bannerAd),
        //       )
        //     : SizedBox.shrink()),
        // appBar: _appBar(),
        body: Column(children: [
          Stack(children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                width: double.infinity,
                height: 287,
                      
                decoration: BoxDecoration(
                
                  gradient: LinearGradient(colors: [
                Color(0Xff4498FF),
                Color(0Xff0072FF),
                      
              ])),),
            )
          ],)
        ],),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () async {
            await Get.to(() => AddTransactionScreen());
            _homeController.getTransactions();
          },
          child: Icon(
            Icons.add,
          ),
        ),
      );
    
  }

  Column Homscreen_tree(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your Balance',
                  style: TextStyle(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w400,
                    color: _themeController.color,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_homeController.selectedCurrency.symbol}${_homeController.totalBalance.value.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IncomeExpence(
                  isIncome: true,
                  symbol: _homeController.selectedCurrency.symbol,
                  amount: _homeController.totalIncome.value,
                ),
                // SizedBox(
                //   width: 30.w,
                // ),
                IncomeExpence(
                  isIncome: false,
                  symbol: _homeController.selectedCurrency.symbol,
                  amount: _homeController.totalExpense.value,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .04.h,
            ),
            _homeController.myTransactions.isEmpty
                ? Container()
                : Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Center(
                            child: IconButton(
                                onPressed: () => _showDatePicker(context),
                                icon: Icon(
                                  Icons.calendar_month,
                                  color: _themeController.color,
                                ))),
                      ),
                      title: Text(
                        _homeController.selectedDate.day == DateTime.now().day
                            ? 'Today'
                            : DateFormat.yMd()
                                .format(_homeController.selectedDate),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 7.h,
                          ),
                          Text(
                            _homeController.totalForSelectedDate < 0
                                ? 'You spent'
                                : 'You earned',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            '${_homeController.selectedCurrency.symbol}${_homeController.totalForSelectedDate.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            PlaceholderInfo(),
            _homeController.myTransactions.isNotEmpty
                ? Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 10.h),
                    child: GestureDetector(
                      onTap: () => Get.to(() => AllTransactionsScreen()),
                      child: Text('Show all transactions,'),
                    ),
                  )
                : SizedBox(),
          ],
        );
  }

  _showDatePicker(BuildContext context) async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2012),
        initialDate: DateTime.now(),
        lastDate: DateTime(2122));
    if (pickerDate != null) {
      _homeController.updateSelectedDate(pickerDate);
    }
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () async {
          _themeController.switchTheme();
        },
        icon: Icon(Get.isDarkMode ? Icons.nightlight : Icons.wb_sunny),
        color: _themeController.color,
      ),
      actions: [
        IconButton(
          onPressed: () => Get.to(() => ChartScreen()),
          icon: Icon(
            Icons.bar_chart,
            size: 27.sp,
            color: _themeController.color,
          ),
        ),
        Row(
          children: [
            Text(
              _homeController.selectedCurrency.currency,
              style: TextStyle(
                fontSize: 14.sp,
                color: _themeController.color,
              ),
            ),
            SizedBox(
              width: 30,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  // customItemsHeight: 10,

                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: _themeController.color,
                  ),
                  items: Currency.currencies
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item.currency,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    _homeController.updateSelectedCurrency((val as Currency));
                  },
                  // itemHeight: 30.h,
                  // dropdownPadding: EdgeInsets.all(4),
                  // dropdownWidth: 105.w,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        )
      ],
    );
  }

  
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 20); // Start from the top-left
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 20); // Define a quadratic Bezier curve
    path.lineTo(size.width, 0); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}