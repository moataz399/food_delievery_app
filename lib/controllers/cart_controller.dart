import 'package:food_delievery_app/data/repository/cart_repo.dart';
import 'package:food_delievery_app/models/product_models.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo, CartRepo});

  Map<int, CartModel> _items = {};

  Map get items => _items;

  void addItems(PopularProductsModel product, int quantity) {
    _items.putIfAbsent(product.id!, () {

      print('Cart is working');
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
  }
}
