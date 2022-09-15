import 'package:food_delievery_app/presentation/screens/address/add_address_page.dart';
import 'package:food_delievery_app/presentation/screens/address/pick_address_map.dart';
import 'package:food_delievery_app/presentation/screens/auth/signin_page.dart';
import 'package:food_delievery_app/presentation/screens/auth/signup_page.dart';
import 'package:food_delievery_app/presentation/screens/cart/cart_history_page.dart';
import 'package:food_delievery_app/presentation/screens/cart/cart_page.dart';
import 'package:food_delievery_app/presentation/screens/food/popular_food_details.dart';
import 'package:food_delievery_app/presentation/screens/food/recommended_food_details.dart';
import 'package:food_delievery_app/presentation/screens/home/home_page.dart';
import 'package:food_delievery_app/presentation/screens/splash_page.dart';
import 'package:get/get.dart';

class AppRouter {
  static const String initial = '/';
  static const String popularFoodDetails = '/popular-food-details';
  static const recommendedFoodDetails = '/recommended-food-details';
  static const String cartPage = '/cartPage';
  static const String splashPage = '/splash-page';
  static const String pickAddressPage = '/pickAddress-page';

  static const String signUpPage = '/signUp-page';
  static const String signInPage = '/signIn-page';
  static const String addressPage = '/address_page';

  static const String cartHistoryPage = '/cart-history-page';

  static String getCartHistoryPage() => '$cartHistoryPage';

  static String getInitial() => '$initial';

  static String getAddressPage() => '$addressPage';

  static String getSignInPage() => '$signInPage';

  static String getSignUpPage() => '$signUpPage';

  static String getSplashPage() => '$splashPage';

  static String getCartPage() => '$cartPage';

  static String getPickAddressPage() => '$pickAddressPage';

  static String getPopularFoodDetails(int pageId, String page) =>
      '$popularFoodDetails?pageId=$pageId&page=$page';

  static String getRecommendedFoodDetails(int pageId, String page) =>
      '$recommendedFoodDetails?pageId=$pageId&page=$page';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: cartHistoryPage, page: () => CartHistoryPage()),
    GetPage(name: initial, page: () => HomePage(), transition: Transition.fade),
    GetPage(name: signInPage, page: () => SignInPage()),
    GetPage(name: signUpPage, page: () => SignUpPage()),
    GetPage(name: addressPage, page: () => AddAddressPage()),
    GetPage(
        name: popularFoodDetails,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetails(
            pageId: int.parse(pageId!),
            page: page!,
          );
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFoodDetails,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetails(
              pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: pickAddressPage,
        page: () {
          PickAddressMap pickAddress = Get.arguments;
          return pickAddress;
        },
        transition: Transition.fadeIn)
  ];
}
