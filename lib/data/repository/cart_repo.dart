import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/data/api/api_client.dart';
import 'package:test/models/cart_model.dart';
import 'package:test/utils/app_constants.dart';

class CartRapo{
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;
  CartRapo({required this.sharedPreferences , required this.apiClient});

  List<String> cart =[];
  List<String> cartHistory=[];

  void addToCartList(List<CartModel> cartList){
    //sharedPreferences.remove(AppConstant.CART_LIST);
    //sharedPreferences.remove(AppConstant.CART_HISTORY_LIST);
    //return;
    var time = DateTime.now().toString();
    cart=[];
    /*
    convert objects to string because sharedpreferences only accepts string
    */

    cartList.forEach((element){
      element.time = time ;
      return cart.add(jsonEncode(element));
      });

    sharedPreferences.setStringList(AppConstant.CART_LIST, cart);
    //print(sharedPreferences.getStringList(AppConstant.CART_LIST));
    //getCartList();
  }

  List<CartModel> getCartList(){
    List<String> carts=[];
    if(sharedPreferences.containsKey(AppConstant.CART_LIST)){
      carts = sharedPreferences.getStringList(AppConstant.CART_LIST)!;
      print("inside getCartList "+carts.toString());
    }
    List<CartModel> cartList=[];

    carts.forEach((element)=>cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }

  List<CartModel> getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstant.CART_HISTORY_LIST)){
      cartHistory = sharedPreferences.getStringList(AppConstant.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory=[];
    cartHistory.forEach((element) =>cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistoryList(String date , String time){

    if(sharedPreferences.containsKey(AppConstant.CART_HISTORY_LIST)){
      cartHistory = sharedPreferences.getStringList(AppConstant.CART_HISTORY_LIST)!;
    }
    for(int i=0 ; i<cart.length; i++){
      
      var cartItem = jsonDecode(cart[i]);
      cartItem['time'] = time;
      cartItem['date'] = date;
      cartHistory.add(jsonEncode(cartItem));
      
    }
    jsonDecode(cartHistory[cartHistory.length]).time = time;
    jsonDecode(cartHistory[cartHistory.length]).date = date;
    removeCart();
    sharedPreferences.setStringList(AppConstant.CART_HISTORY_LIST, cartHistory);
    for(int j=0;j<getCartHistoryList().length;j++){
      print("The time for the order is "+getCartHistoryList()[j].time.toString());
    }
  }

  void removeCart(){
    cart=[];
    sharedPreferences.remove(AppConstant.CART_LIST);
  }

  void clearCartHistory(){
    removeCart();
    cartHistory=[];
    sharedPreferences.remove(AppConstant.CART_HISTORY_LIST);
  }

  Future<Response> registration(Map<String ,List<Map<String,int>>> item)async {
    return await apiClient.postData(AppConstant.ADD_CART_URI , item);
  }

  Future<Response> getCartElement()async{
    return await apiClient.getData(AppConstant.GET_CART_URI);
  }

}