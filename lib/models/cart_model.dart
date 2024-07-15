 import 'package:test/models/products_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? date;
  String? time;
  ProductModel? product;

  CartModel(
      {this.id,
      this.name,
      this.price,
      this.img,
      this.quantity,
      this.isExist,
      this.date,
      this.time,
      this.product,
    });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    date= json['date'];
    time = json['time'];
    product = ProductModel.fromJson(json['product']) ;
  }

  Map<String , dynamic> toJson(){
    return{
      "id":this.id,
    "name":this.name,
    "price":this.price,
    "img":this.img,
    "quantity":this.quantity,
    "isExist":this.isExist,
    "date":this.date,
    "time":this.time,
    "product":this.product!.toJson(),

    };
  }

}