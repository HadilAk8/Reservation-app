import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controllers/cart_controller.dart';
import 'package:test/controllers/reservation_controller.dart';
import 'package:test/data/repository/product_repo.dart';
import 'package:test/models/cart_model.dart';
import 'package:test/models/products_model.dart';
import 'package:test/utils/app_constants.dart';
import 'package:test/utils/colors.dart';

class ProductController extends GetxController {
  final ProductRepo productRepo;

 ProductController({required this.productRepo});

  List<dynamic> _productList=[];
  List<dynamic> get  productList => _productList;
  List<dynamic> _productItalList=[];
  List<dynamic> get  producItalList => _productItalList;
  List<dynamic> _productJapList=[];
  List<dynamic> get  productJapList => _productJapList;
  List<dynamic> _productDesList=[];
  List<dynamic> get  productDesList => _productDesList;
  List<dynamic> _productDrinList=[];
  List<dynamic> get  productDrinList => _productDrinList;
  List<dynamic> _productCatList=[];
  List<dynamic> get  productCatList => _productCatList;

  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get  quantity => _quantity;
  int _inCartItem=0;
  int  get inCartItem=>_inCartItem+_quantity;

  String date = Get.find<ReservationController>().date;
  String time = Get.find<ReservationController>().time;

  Future<void> getProductList()async {
    Response response0 = await productRepo.getProductList(AppConstant.ALG_PRODUCT_URI);
     
    Response response1 = await productRepo.getProductList(AppConstant.ITA_PRODUCT_URI);
      
    Response response2 = await productRepo.getProductList(AppConstant.JAP_PRODUCT_URI);
     
    Response response3 = await productRepo.getProductList(AppConstant.DESSERT_PRODUCT_URI);
      
    Response response4 = await productRepo.getProductList(AppConstant.DRINK_PRODUCT_URI);
    
    if(response0.statusCode==200 && response1.statusCode==200 && response2.statusCode==200 && response3.statusCode==200 && response4.statusCode==200){
      _productList=[];
      _productList.addAll(Product.fromJson(response0.body).products);
      _productItalList=[];
      _productItalList.addAll(Product.fromJson(response1.body).products);
      _productJapList=[];
      _productJapList.addAll(Product.fromJson(response2.body).products);
      _productDesList=[];
      _productDesList.addAll(Product.fromJson(response3.body).products);
      _productDrinList=[];
      _productDrinList.addAll(Product.fromJson(response4.body).products);
      print("we get data product");
      print(AppConstant.BASE_URL+AppConstant.UPLOAD_URL+_productList[0].img!);
      _isLoaded = true;
      update();
    }else{
      print("we don't get data product");
  }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity + 1);
      //print("number of items is "+_quantity.toString());
    }else{

      _quantity = checkQuantity(_quantity - 1);
      //print("number of items is "+_quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity){
    if((_inCartItem+quantity)<0){
      Get.snackbar("Item Count", "You can't reduce more !", backgroundColor: AppColors.mainColor , colorText: Colors.white);
      if(_inCartItem>0){
        _quantity= -_inCartItem;
        return _quantity;
      }
      return 0;
    }else if((_inCartItem+quantity)>20){
      Get.snackbar("Item Count", "You can't add more !", backgroundColor: AppColors.mainColor , colorText: Colors.white);
      return 20;
    }else{
      return quantity;
    }
  }
  
  void initProduct(ProductModel product , CartController cart){
      _quantity=0;
      _inCartItem=0;
      _cart=cart;
      var exist =false;
      exist = _cart.existInCart(product);
      //if exist
      //get from storage _inCartItems
      if (exist) {
        _inCartItem=_cart.getQuantity(product);
      }
  }

  void addItem(ProductModel product ){
      _cart.addItem(product, _quantity, date , time);

      _quantity=0;
      _inCartItem=_cart.getQuantity(product);

      _cart.items.forEach((key, value) {
        print("The id is "+value.id.toString()+" and the quantity is "+value.quantity.toString());
      });
   
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }
  
}