import 'package:flutter/material.dart';
import 'package:food_delievery_app/controllers/popular_product_controller.dart';
import 'package:food_delievery_app/controllers/recommended_food_controller.dart';
import 'package:get/get.dart';

import 'app_router.dart';
import 'constants/strings.dart';

import 'helper/dependencies.dart' as dep;

late String initialRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dep.init();


  runApp(MyApp(

  ));
}

class MyApp extends StatelessWidget {
  MyApp();



  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedFoodController>().getRecommendedProductList();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:AppRouter.initial ,
      getPages: AppRouter.routes,
    );
  }


}
