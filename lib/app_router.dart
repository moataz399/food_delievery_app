import 'package:flutter/material.dart';
import 'package:food_delievery_app/presentation/screens/food/food_detail.dart';
import 'package:food_delievery_app/presentation/screens/food/recommended_foo_details.dart';
import 'package:food_delievery_app/presentation/screens/home/main_food_page.dart';

import 'constants/strings.dart';

class AppRouter {
  AppRouter() {
    String initialRoute;
  }

  Route ? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainFoodPage:
        return MaterialPageRoute(builder: (_) => const MainFoodPage());
      case foodDetails:
        return MaterialPageRoute(builder: (_) => const FoodDetails());
      case recommendedFoodDetails:
        return MaterialPageRoute(builder: (_) => const RecommendedFoodDetails());
    }
   
  }
}