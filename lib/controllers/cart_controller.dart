import 'package:flutter/material.dart';
import 'package:food_delievery_app/data/repository/cart_repo.dart';
import 'package:food_delievery_app/models/product_models.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo, CartRepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

  void addItems(PopularProductsModel product, int quantity) {
    int totalQuantity = 0;
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;

        return CartModel(
          id: value.id,
          img: value.img,
          name: value.name,
          price: value.price,
          isExist: true,
          quantity: value.quantity! + quantity,
          time: DateTime.now().toString(),
        );
      });

      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            img: product.img,
            name: product.name,
            price: product.price,
            isExist: true,
            quantity: quantity,
            time: DateTime.now().toString(),
          );
        });
      } else {
        Get.snackbar(
            'Item count ', "you should  at least have 1 item in the cart ",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }
  }

  bool existInCart(PopularProductsModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(PopularProductsModel product) {
    int quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalItems = 0;
    _items.forEach((key, value) {
      totalItems = totalItems + value.quantity!;
    });

    return totalItems;
  }
}
