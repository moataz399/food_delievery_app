import 'package:food_delievery_app/constants/strings.dart';
import 'package:food_delievery_app/controllers/popular_product_controller.dart';
import 'package:food_delievery_app/controllers/recommended_food_controller.dart';
import 'package:food_delievery_app/data/api/api_client.dart';
import 'package:food_delievery_app/data/repository/popular_product_repo.dart';
import 'package:food_delievery_app/data/repository/recommended_food_repo.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Future<void> init() async {
  Get.lazyPut(() => ApiClient(appBaseUrl: appBaseUrl));
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));

  Get.lazyPut(() => RecommendedFoodRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedFoodController( recommendedFoodRepo:Get.find(),));
}
