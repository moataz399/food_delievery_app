import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_app/app_router.dart';
import 'package:food_delievery_app/presentation/screens/auth/signup_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../base/show_custom_message.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../widgets/text_field.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  void _login(AuthController authController) {
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();

    if (phone.isEmpty) {
      showCustomSnackBar('type in your phone address', title: "phone address");

    } else if (password.isEmpty) {
      showCustomSnackBar('type in your password ', title: "Password ");
    } else if (password.length < 6) {
      showCustomSnackBar('password is less than 6 characters  ',
          title: "password  ");
    } else {
      authController.login(phone, password).then((status) {
        if (status.isSuccess) {
          print("success login");

          Get.offNamed(AppRouter.getInitial());

        } else {
          showCustomSnackBar(status.message);
          print('failed');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.width20),
                        child: SafeArea(
                          child: Text(
                            'Hello',
                            style: TextStyle(
                                fontSize: Dimensions.font20 * 3,
                                color: Color(0xFF07060C),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.width20),
                        child: Text(
                          'Sign into your account',
                          style: TextStyle(
                            fontSize: Dimensions.font20,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height30,
                      ),
                      AppTextField(
                        obSecure: false,
                        textEditingController: phoneController,
                        hintText: 'phone',
                        icon: Icons.phone,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTextField(
                        obSecure: true,
                        textEditingController: passwordController,
                        hintText: 'password',
                        icon: Icons.password_sharp,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          _login(authController);
                        },
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radius30,
                                )),
                            width: Dimensions.screenWidth / 2,
                            height: Dimensions.screenHeight / 13,
                            child: Center(
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimensions.font26),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('t');
                                },
                              text: 'Don\'t have an account?',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20,
                              ),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.to(() => SignUpPage(),
                                        transition: Transition.fade),
                                  text: ' create',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.mainBlackColor,
                                    fontSize: Dimensions.font20,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                );
        },
      ),
    );
  }
}
