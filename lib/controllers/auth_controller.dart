import 'package:get/get.dart';

import '../data/repository/auth_repo.dart';
import '../models/response_model.dart';
import '../models/signup_model.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpModel signUpModel) async {
    _isLoading = true;
    update();

    Response response = await authRepo.registration(signUpModel);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      print('fffff');
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;

    update();
    return responseModel;
  }

  Future<ResponseModel> login(String phone, String password) async {
    print('getting token');
    print(authRepo.getUserToken().toString());

    _isLoading = true;
    update();

    Response response = await authRepo.login(phone, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print('backend token');
      authRepo.saveUserToken(response.body["token"]);

      print(response.body['token'].toString());
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      print("${response.statusCode}ffffffffff");
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;

    update();
    return responseModel;
  }

  void saveUserPhoneNumberAndPassword(String phone, String password) {
    authRepo.saveUserPhoneNumberAndPassword(phone, password);
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }
}
