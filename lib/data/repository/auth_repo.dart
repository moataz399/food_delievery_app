import 'package:food_delievery_app/constants/strings.dart';
import 'package:food_delievery_app/data/api/api_client.dart';
import 'package:food_delievery_app/models/signup_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> registration(SignUpModel signUpModel) async {
    return await apiClient.postData(
        AppStrings.registerUri, signUpModel.toJson());
  }

  Future<Response> login(String email, String password) async {
    return await apiClient
        .postData(AppStrings.loginUri, {"email": email, "password": password});
  }

  Future<bool >saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    // return await sharedPreferences.remove(AppStrings.TOKEN);
    return await sharedPreferences.setString(AppStrings.TOKEN, token);
  }

  void saveUserPhoneNumberAndPassword(String phone, String password) {
    try {
      sharedPreferences.setString(AppStrings.phone, phone);
      sharedPreferences.setString(AppStrings.password, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppStrings.TOKEN) ?? "none";
  }

 bool userLoggedIn()  {
    return  sharedPreferences.containsKey(AppStrings.TOKEN) ;
  }


  bool clearSharedData(){
sharedPreferences.remove(AppStrings.TOKEN);
sharedPreferences.remove(AppStrings.password);
sharedPreferences.remove(AppStrings.phone);

apiClient.token='';
apiClient.updateHeader('');
return true;


  }
}
