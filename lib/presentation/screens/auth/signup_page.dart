import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_app/controllers/auth_controller.dart';
import 'package:food_delievery_app/presentation/screens/auth/signin_page.dart';
import 'package:food_delievery_app/presentation/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../../app_router.dart';
import '../../../base/show_custom_message.dart';
import '../../../models/signup_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../widgets/text_field.dart';

var formKey = GlobalKey<FormState>();

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar('type in your email address',
            title: "Email address");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar('type in your email address ',
            title: " Valid email address ");
      } else if (password.isEmpty) {
        showCustomSnackBar('type in your password ', title: "Password ");
      } else if (password.length < 6) {
        showCustomSnackBar('password is less than 6 characters  ',
            title: "password  ");
      } else if (name.isEmpty) {
        showCustomSnackBar('type in your name ', title: "Name ");
      } else if (phone.isEmpty) {
        showCustomSnackBar('type in your phone number ', title: "Phone number");
      } else {
        SignUpModel signUpModel = SignUpModel(
            email: email, name: name, password: password, phone: phone);

        print(signUpModel.toString());

        authController.registration(signUpModel).then((status) {
          if (status.isSuccess) {
            print("success register");

            //   Get.toNamed(AppRouter.getInitial());

            Get.offNamed(AppRouter.getInitial());
          } else {
            showCustomSnackBar(status.message);
            print('failed');
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (_authController) {
            return !_authController.isLoading
                ? SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SafeArea(
                          child: Container(
                            width: 190,
                            height: 80,
                            child: const Text(
                              'Create New Account',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Color(0xFF07060C),
                                  fontFamily: 'Europa',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        AppTextField(
                          obSecure: false,
                          textEditingController: emailController,
                          hintText: 'email',
                          icon: Icons.email,
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
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        AppTextField(
                          obSecure: false,
                          textEditingController: nameController,
                          hintText: 'name',
                          icon: Icons.person,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        AppTextField(
                          obSecure: false,
                          textEditingController: phoneController,
                          hintText: 'phone',
                          icon: Icons.phone,
                        ),
                        SizedBox(
                          height: Dimensions.height45,
                        ),
                        GestureDetector(
                          onTap: () {
                            _registration(_authController);
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
                                child: BigText(
                                  text: 'Sign Up',
                                  color: Colors.white,
                                  size: Dimensions.font26,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        RichText(
                            text: TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(() => SignInPage(),
                                      transition: Transition.fade),
                                text: 'have an account already ?',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20,
                                )))
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ));
          },
        ));
  }
}
