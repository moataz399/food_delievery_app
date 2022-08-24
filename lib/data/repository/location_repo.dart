import 'package:food_delievery_app/constants/strings.dart';
import 'package:food_delievery_app/data/api/api_client.dart';
import 'package:food_delievery_app/models/signup_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({required this.apiClient, required this.sharedPreferences});

}
