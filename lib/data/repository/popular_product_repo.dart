import 'package:food_delievery_app/constants/strings.dart';
import 'package:food_delievery_app/data/api/api_client.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

Future<Response> getPopularProductList()async{

  return await apiClient.getData(AppStrings.popularProductUri);
}


}
