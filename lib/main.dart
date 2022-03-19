import 'package:flutter/material.dart';
import 'package:food_delievery_app/controllers/popular_product_controller.dart';
import 'package:get/get.dart';

import 'app_router.dart';
import 'constants/strings.dart';

import 'helper/dependencies.dart' as dep;

late String initialRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dep.init();
  initialRoute = recommendedFoodDetails;


  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

   MyApp({required this.appRouter});

  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();


    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
      initialRoute: initialRoute,
    );
  }
}
