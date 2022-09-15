import 'package:flutter/material.dart';
import 'package:food_delievery_app/controllers/cart_controller.dart';
import 'package:food_delievery_app/data/repository/popular_product_repo.dart';
import 'package:food_delievery_app/models/cart_model.dart';
import 'package:food_delievery_app/models/product_models.dart';
import 'package:food_delievery_app/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  PopularProductController({required this.popularProductRepo});

  final PopularProductRepo popularProductRepo;

  late CartController _cartController;

  List<dynamic> _popularList = [];

  List<dynamic> get popularProductList => _popularList;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;
  int _quantity = 0;

  int get quantity => _quantity;

  int _inCartItems = 0;

  int get inCartItems => _inCartItems + _quantity;

  int get totalItems => _cartController.totalItems;

  List<CartModel> get getItems {
    return _cartController.getItems;
  }

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();

    if (response.statusCode == 200) {
      print(response.toString());
      _popularList = [];
      _popularList.addAll(Product.fromJson(response.body).products);

      _isLoaded = true;
      update();
    } else {
      print(" status code = ${response.statusCode}");
      print('popular products error ');
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      print(' number of items  ' + _quantity.toString());
    } else {
      _quantity = checkQuantity(_quantity - 1);
      print(' number of items  ' + _quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar('Item count ', "you can't reduce more ",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);

      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar('Item count ', "you can't add more ",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductsModel product, CartController cartController) {
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cartController;
    bool exist = false;
    exist = _cartController.existInCart(product);
    if (exist) {
      _inCartItems = _cartController.getQuantity(product);
    }
    print('the quantity is ' + _inCartItems.toString());
  }

  void addItem(ProductsModel product) {
    _cartController.addItems(product, _quantity);
    _quantity = 0;
    _inCartItems = _cartController.getQuantity(product);
    _cartController.items.forEach((key, value) {
      print("the id is " +
          value.id.toString() +
          ' the quantity is ' +
          value.quantity.toString());
    });
    update();
  }
}
