import 'package:flutter/material.dart';
import 'package:food_delievery_app/controllers/auth_controller.dart';
import 'package:food_delievery_app/controllers/location_controller.dart';
import 'package:food_delievery_app/controllers/user_controller.dart';
import 'package:food_delievery_app/presentation/widgets/account_widget.dart';
import 'package:food_delievery_app/presentation/widgets/app_icon.dart';
import 'package:food_delievery_app/presentation/widgets/big_text.dart';
import 'package:food_delievery_app/utils/colors.dart';
import 'package:get/get.dart';

import '../../../app_router.dart';
import '../../../controllers/cart_controller.dart';
import '../../../utils/dimensions.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();

    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: BigText(
          text: 'profile',
          color: Colors.white,
          size: 24,
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return userLoggedIn
            ? (userController.isLoading
                ? Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    child: Column(
                      children: [
                        AppIcon(
                          icon: Icons.person,
                          iconsSize: Dimensions.height30 + Dimensions.height45,
                          size: Dimensions.height15 * 10,
                          backGroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                        ),
                        SizedBox(height: Dimensions.height30),
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            children: [
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.person,
                                  iconsSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                  backGroundColor: AppColors.mainColor,
                                  iconColor: Colors.white,
                                ),
                                bigText: BigText(
                                  text: userController.userModel.name,
                                ),
                              ),
                              SizedBox(height: Dimensions.height20),
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.phone,
                                  iconsSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                  backGroundColor: AppColors.yellowColor,
                                  iconColor: Colors.white,
                                ),
                                bigText: BigText(
                                  text: userController.userModel.phone,
                                ),
                              ),
                              SizedBox(height: Dimensions.height20),
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.email,
                                  iconsSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                  backGroundColor: AppColors.yellowColor,
                                  iconColor: Colors.white,
                                ),
                                bigText: BigText(
                                  text: userController.userModel.email,
                                ),
                              ),
                              SizedBox(height: Dimensions.height20),
                              GetBuilder<LocationController>(
                                  builder: (locationController) {
                                if (userLoggedIn &&
                                    locationController.addressList.isEmpty) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.offNamed(AppRouter.getAddressPage());
                                    },
                                    child: AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.location_on,
                                        iconsSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                        backGroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                      ),
                                      bigText: BigText(
                                        text: 'fill in your address',
                                      ),
                                    ),
                                  );
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.offNamed(AppRouter.getAddressPage());
                                    },
                                    child: AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.location_on,
                                        iconsSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                        backGroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                      ),
                                      bigText: BigText(
                                        text: 'your address',
                                      ),
                                    ),
                                  );
                                }
                              }),
                              SizedBox(height: Dimensions.height20),
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.message,
                                  iconsSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                  backGroundColor: Colors.redAccent,
                                  iconColor: Colors.white,
                                ),
                                bigText: BigText(
                                  text: 'messages',
                                ),
                              ),
                              SizedBox(height: Dimensions.height20),
                              GestureDetector(
                                onTap: () {
                                  if (Get.find<AuthController>()
                                      .userLoggedIn()) {
                                    Get.find<AuthController>()
                                        .clearSharedData();
                                    Get.find<CartController>().clearCartList();
                                    Get.find<CartController>().clear();

                                    Get.find<LocationController>()
                                        .clearAddressList();

                                    Get.offNamed(AppRouter.getSignUpPage());
                                  } else {
                                    print('you logged out');
                                  }
                                },
                                child: AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.logout,
                                    iconsSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                    backGroundColor: Colors.redAccent,
                                    iconColor: Colors.white,
                                  ),
                                  bigText: BigText(
                                    text: 'log out',
                                  ),
                                ),
                              ),
                              SizedBox(height: Dimensions.height20),
                            ],
                          ),
                        ))
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: AppColors.mainColor,
                    ),
                  ))
            : Center(
                child: Container(
                  child: const Center(
                    child: Text('you must login'),
                  ),
                ),
              );
      }),
    );
  }
}
