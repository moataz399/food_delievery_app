import 'package:food_delievery_app/controllers/popular_product_controller.dart';
import 'package:food_delievery_app/data/api/api_client.dart';
import 'package:food_delievery_app/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

Future<void> init() async {
  Get.lazyPut(() => ApiClient(appBaseUrl: 'https://mvs.bslmeiyu.com'));
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
}
