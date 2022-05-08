import 'package:shop_app/data/model/product_model.dart';

class CartModel {
  bool? status;
  List<CartItem>? data;

  CartModel({this.status, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data']['cart_items'] != null) {
      data!.add(CartItem.fromJson(json['data']['cart_items']));
    }
  }
}

class CartItem {
  int? id;
  int? quantity;
  Product? product;

  CartItem({this.id, this.quantity, this.product});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}
