import 'package:food_delievery_app/constants/strings.dart';
import 'package:food_delievery_app/data/api/api_client.dart';
import 'package:get/get.dart';

class RecommendedFoodRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedFoodRepo({required this.apiClient});

  Future<Response> getRecommendedFoodList()async{

    return await apiClient.getData(recommendedProductUri);
  }


}
