import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];
  var time = DateTime.now().toString();

  void addToCartList(List<CartModel> cartList) {
    // sharedPreferences.remove('cart-list');
    // sharedPreferences.remove('cart-list-history');
    //
    // return ;
    cart = [];

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList('cart-list', cart);

    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];

    if (sharedPreferences.containsKey('cart-list')) {
      carts = sharedPreferences.getStringList('cart-list')!;
    }
    List<CartModel> cartList = [];
    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey("cart-list-history")) {
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList("cart-list-history")!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));

    return cartListHistory;
  }

  void addToCartHistory() {
    if (sharedPreferences.containsKey("cart-list-history")) {
      cartHistory = sharedPreferences.getStringList("cart-list-history")!;
    }
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }
    removeCard();
    sharedPreferences.setStringList('cart-list-history', cartHistory);

    print(
        'the length of history list ' + getCartHistoryList().length.toString());

    for (int i = 0; i < getCartHistoryList().length; i++) {
      print(getCartHistoryList()[0].time.toString());
    }
  }

  void removeCard() {
    cart = [];
    sharedPreferences.remove('cart-list');
  }
}
