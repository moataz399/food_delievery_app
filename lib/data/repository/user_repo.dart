import 'package:food_delievery_app/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../constants/strings.dart';

class UserRepo {
  final ApiClient apiClient;

  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppStrings.userInfo);
  }
}
