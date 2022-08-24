import 'package:flutter/material.dart';
import 'package:food_delievery_app/presentation/screens/home/main_food_page.dart';
import 'package:food_delievery_app/utils/colors.dart';
import '../account/account_page.dart';
import '../cart/cart_history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List pages = [
    MainFoodPage(),

    Container(
      child: Center(child: Text('page 1')),
    ),
    CartHistoryPage(),
    // Container(
    //   child: Center(
    //       child: Center(
    //     child: GestureDetector(
    //       onTap: () {
    //         if (!Get.find<AuthController>().userLoggedIn()) {
    //           Get.find<AuthController>().clearSharedData();
    //           Get.find<AuthController>().clearSharedData();
    //           Get.find<CartController>().clearCartList();
    //           Get.find<CartController>().clear();
    //
    //           Get.toNamed(AppRouter.getSignUpPage());
    //         } else {
    //           print('u logged out');
    //         }
    //       },
    //       child: Center(
    //         child: Container(
    //           decoration: BoxDecoration(
    //               color: Colors.red,
    //               borderRadius: BorderRadius.circular(
    //                 Dimensions.radius30,
    //               )),
    //           width: Dimensions.screenWidth / 2,
    //           height: Dimensions.screenHeight / 13,
    //           child: Center(
    //             child: Text(
    //               'log out',
    //               style: TextStyle(
    //                   color: Colors.white, fontSize: Dimensions.font26),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   )),
    // ),
    AccountPage(),
  ];

  void onTapNav(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapNav,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        items: const [
          BottomNavigationBarItem(label: 'home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'history', icon: Icon(Icons.archive)),
          BottomNavigationBarItem(
              label: 'cart', icon: Icon(Icons.shopping_cart)),
          BottomNavigationBarItem(label: 'me', icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
