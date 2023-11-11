
import 'package:food_delievery_app/app_router.dart';
import 'package:food_delievery_app/base/show_custom_message.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';

class ApiChecker{

  static void checkApi(Response response){
    if (response.statusCode == 401){
      Get.offNamed(AppRouter.getSignInPage());
    }else{
      showCustomSnackBar(response.statusText!);
    }

    }

}
