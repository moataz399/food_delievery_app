import 'package:flutter/material.dart';
import 'package:food_delievery_app/controllers/cart_controller.dart';
import 'package:food_delievery_app/controllers/popular_product_controller.dart';
import 'package:food_delievery_app/controllers/recommended_food_controller.dart';
import 'package:food_delievery_app/presentation/screens/auth/signup_page.dart';
import 'package:get/get.dart';

import 'app_router.dart';

import 'helper/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dep.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedFoodController>(builder: (_) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: AppRouter.getSplashPage(),
            getPages: AppRouter.routes,
          );
        });
      },
    );
  }
}
