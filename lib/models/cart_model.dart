import 'package:food_delievery_app/models/product_models.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  bool? isExist;
  int? quantity;
  String? time;
  ProductsModel? product;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.isExist,
    this.quantity,
    this.time,
    this.product,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    price = json['price'];

    img = json['img'];

    time = json['time'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    product = ProductsModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'img': this.img,
      'time': this.time,
      'price': this.price,
      'isExist': this.isExist,
      'quantity': this.quantity,
      "product": this.product!.toJson(),
    };
  }
}
