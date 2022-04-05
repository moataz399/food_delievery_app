import 'package:flutter/material.dart';
import 'package:food_delievery_app/presentation/screens/food/popular_food_details.dart';
import 'package:food_delievery_app/presentation/screens/food/recommended_food_details.dart';
import 'package:food_delievery_app/presentation/screens/home/main_food_page.dart';
import 'package:get/get.dart';

import 'constants/strings.dart';

class AppRouter {
  static const String initial = '/';
  static const String popularFoodDetails = '/popular-food-details';
  static const recommendedFoodDetails = '/recommended-food-details';

  static String getInitial() => '$initial';

  static String getPopularFoodDetails(int pageId) =>
      '$popularFoodDetails?pageId=$pageId ';

  static String getRecommendedFoodDetails(int pageId) =>
      '$recommendedFoodDetails?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainFoodPage()),
    GetPage(
        name: popularFoodDetails,
        page: () {
          var pageId = Get.parameters['pageId'];
          return PopularFoodDetails(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFoodDetails,
        page: () {
          var pageId = Get.parameters['pageId'];
          return RecommendedFoodDetails(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn),
  ];
}
