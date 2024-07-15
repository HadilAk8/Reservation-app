import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/data/repository/cart_repo.dart';
import 'package:test/models/cart_model.dart';
import 'package:test/models/products_model.dart';
import 'package:test/models/response_model.dart';
import 'package:test/utils/colors.dart';

class CartController extends GetxController{
  final CartRapo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items={};

  Map<int, CartModel> get  items => _items;
  //only for storage and sharedpreferences
  List<CartModel> storageItems=[];
  int _cartElement=0;
  int get cartElement=>_cartElement;

  bool _isLoaded=false;
  bool get isLoaded => _isLoaded;

  void addItem(ProductModel product , int quantity , String date , String time ){
    var totalQuantity=0;
    if(_items.containsKey(product.id!)){
      _items.update(product.id!, (value) {

        totalQuantity=value.quantity!+quantity;

        return CartModel(
          id :value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity!+quantity,
          isExist : true,
          date: date,
          time : time,
          product: product,
        );
      });

      if(totalQuantity<=0){
        _items.remove(product.id);
      }
    }else{
      if(quantity>0){
        _items.putIfAbsent(product.id! , (){ 
        return CartModel(
          id :product.id,
          name: product.nomP,
          price: product.price,
          img: product.img,
          quantity: quantity,
          isExist : true,
          date: date,
          time : time,
          product: product,
        );
      });
      }else{
        Get.snackbar("Item count", "You should at least add an item in the cart!", backgroundColor: AppColors.mainColor , colorText: Colors.white);
      }
    }
    cartRepo.addToCartList(getItems);
    update();
    
  }

  bool existInCart(ProductModel product){
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product){
    var quantity=0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) { 
        if(key==product.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems{
    var totalQuantity=0;
    _items.forEach((key, value) {
     totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems{
   return _items.entries.map((e){
      return e.value;
    }).toList();
  }

  int get totalAmount{
  var total=0;

  _items.forEach((key, value) {
    total += value.quantity! * value.price! ;
  });
  return total;
}

  List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items){
    storageItems = items ;
    //print("length of cart items "+storageItems.length.toString());
    for(int i=0; i<storageItems.length ; i++){
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory(String date , String time){
    cartRepo.addToCartHistoryList(date , time);
    clear();
  }

  void clear(){
   _items={};
   update(); 
  }

  List<CartModel> getCartHistoryList(){
      return cartRepo.getCartHistoryList();
    }

  set setItems(Map<int , CartModel> setItems){
    _items = {};
    _items = setItems ;
  }

  void addToCartList(){
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCartHistory(){
    cartRepo.clearCartHistory();
    update();
   }

  Future<ResponseModel> registration (Map<String ,List<Map<String,int>>> item) async {
    _isLoaded =true;
    update();
    Response response = await cartRepo.registration(item);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      responseModel = ResponseModel(true, "do perfectly");
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoaded =true;
    update();
    return responseModel;
  }

  Future<void> getCartElement()async {
    Response response = await cartRepo.getCartElement();
    if(response.statusCode==200){
        _cartElement = 0;

        _cartElement = response.body["idC"];
        print("we get cart data");

        _isLoaded = true;
        update();
      }else{
        print("we don't get data!!!!");
        }
  }

}