import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:test/base/no_data_page.dart';
import 'package:test/base/show_custom_snackbar.dart';
import 'package:test/controllers/cart_controller.dart';
import 'package:test/controllers/product_controller.dart';
import 'package:test/controllers/popular_product_controller.dart';
import 'package:test/controllers/reservation_controller.dart';
import 'package:test/controllers/table_res_controller.dart';
import 'package:test/controllers/user_controller.dart';
import 'package:test/models/cart_model.dart';
import 'package:test/models/reservation_model.dart';
import 'package:test/models/table_model.dart';
import 'package:test/routes/route_helper.dart';
import 'package:test/utils/app_constants.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/dimensions.dart';
import 'package:test/widgets/app_icon.dart';
import 'package:test/widgets/big_text.dart';
import 'package:test/widgets/small_text.dart';

// ignore: must_be_immutable
class CartPage extends StatelessWidget {

  String page;
  CartPage({Key? key ,  required this.page}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    String date = Get.find<ReservationController>().date;
    String time = Get.find<ReservationController>().time;
    bool verification(){
      if (Get.find<ReservationController>().tableName != "") {
        return true;
      }else{
        return false;
      }
    }
    void _registertion(CartController cartController){
      List<Map<String,int>> item=[];
      Map<String,int> regCart= {"idP":0 , "quantity":0};
      int idU = Get.find<UserController>().userModel.id;
      print(idU);
      List<int> keysList = cartController.items.keys.toList();
      for (var key in keysList) {
      
      CartModel? cartItem = Get.find<CartController>().items[key];
    
      regCart = {
        "idP": cartItem?.id as int, 
        "quantity": cartItem?.quantity as int
      };

    item.add(regCart);
  }
  Map<String ,List<Map<String,int>>> data = {"items":item};
      String? dateR = date ;
      String? timeR = time;
      TableModel? table = Get.find<TableResController>().findTableList(Get.find<ReservationController>().tableName);
      cartController.registration(data).then((status) {
          if(status.isSuccess){
            print("Success registration Cart");
            cartController.addToHistory(dateR , timeR);
            Get.find<CartController>().getCartElement();
          }else{
            print("error cart");
            print(status.message.toString());
            showCustomSnackBar(status.message);
          }
        });
      int idC = Get.find<CartController>().cartElement as int;
      ReservationModel reservationModel = ReservationModel(timeR: timeR , dateR: dateR.substring(0,10) , idTable: table?.id , idUser: idU , idCart: idC+1) ;
      Get.find<ReservationController>().registration(reservationModel).then((status){
          if(status.isSuccess){
            print("Success registration Table");
            Get.offNamed(RouteHelper.getConfarmationPage() , arguments : {"table" : table});
          }else{
            print("error table");
            showCustomSnackBar(status.message);
          }
        });
    
  }
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20*3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: AppIcon(icon: Icons.arrow_back_ios, iconColor: Colors.white, backgroundColor: AppColors.mainColor, iconSize: Dimensions.iconsize24 ,),
                  ),
                SizedBox(width: Dimensions.width20*5,),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(icon: Icons.home_outlined, iconColor: Colors.white, backgroundColor: AppColors.mainColor, iconSize: Dimensions.iconsize24 ,),
                  ),
                AppIcon(icon: Icons.shopping_cart, iconColor: Colors.white, backgroundColor: AppColors.mainColor, iconSize: Dimensions.iconsize24 ,),
              ],
              ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0?Positioned(
            top:Dimensions.height20*5,
            left:Dimensions.width20 ,
            right:Dimensions.width20 ,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height15),
              
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (cartController){
                  var _cartList = cartController.getItems;
                  return ListView.builder(
                    itemCount: _cartList.length,
                    itemBuilder: (_,index){
                      return Container(
                        width: double.maxFinite,
                        height: Dimensions.height20*5,
                        margin: EdgeInsets.only(bottom: Dimensions.height10 ,),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                var productIndex = Get.find<ProductController>()
                                .productList
                                .indexOf(_cartList[index].product!);
                                if(productIndex>=0){
                                  Get.toNamed(RouteHelper.getPopularFood(productIndex,"cartpage",0));
                                }else{
                                  productIndex = Get.find<ProductController>()
                                  .producItalList
                                  .indexOf(_cartList[index].product!);
                                  if(productIndex>=0){
                                    Get.toNamed(RouteHelper.getPopularFood(productIndex,"cartpage",1));
                                  }else{
                                    productIndex = Get.find<ProductController>()
                                    .productJapList
                                    .indexOf(_cartList[index].product!);
                                    if(productIndex>=0){
                                      Get.toNamed(RouteHelper.getPopularFood(productIndex,"cartpage",2));
                                    }else{
                                      productIndex = Get.find<ProductController>()
                                      .productDesList
                                      .indexOf(_cartList[index].product!);
                                      if(productIndex>=0){
                                        Get.toNamed(RouteHelper.getPopularFood(productIndex,"cartpage",3));
                                      }else{
                                        productIndex = Get.find<ProductController>()
                                        .productDrinList
                                        .indexOf(_cartList[index].product!);
                                        if(productIndex>=0){
                                          Get.toNamed(RouteHelper.getPopularFood(productIndex,"cartpage",4));
                                        }else{
                                          productIndex = Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(_cartList[index].product!);
                                          if(productIndex<0){
                                            Get.snackbar("History product","Product review is not availble for history product!" , backgroundColor: Colors.redAccent , colorText: Colors.white);
                                          }else{
                                            Get.toNamed(RouteHelper.getRecommendedFood(productIndex, "cartpage"));
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              },
                              child: Container(
                                width: Dimensions.height20*5,
                                height: Dimensions.height20*5,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit:BoxFit.cover,
                                    image: NetworkImage(
                                      AppConstant.BASE_URL+AppConstant.UPLOAD_URL+cartController.getItems[index].img!,
                                    ),
                                    ),
                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: Dimensions.width10,),
                            Expanded(
                              child:Container(
                                height: Dimensions.height20*5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    BigText(text: cartController.getItems[index].name!,color: Colors.black54,),
                                    SmallText(text: "Spicy"),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(text: cartController.getItems[index].price!.toString()+" DA",color: Colors.redAccent,),
                                        Container(
                                          padding: EdgeInsets.only(top: Dimensions.height10 , bottom: Dimensions.height10 , left: Dimensions.width10 , right: Dimensions.width10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  if(page =="food"){
                                                  cartController.addItem(_cartList[index].product!,-1,date, time);
                                                  }else{
                                                    showCustomSnackBar("You can't reduce");
                                                  }
                                                },
                                                child: Icon(Icons.remove , color: AppColors.signColor,size: Dimensions.font20,),
                                              ),
                                              SizedBox(width: Dimensions.width10/2,),
                                              BigText(text: _cartList[index].quantity.toString() ,size: Dimensions.font16,),
                                              SizedBox(width: Dimensions.width10/2,),
                                              GestureDetector(
                                                onTap: () {
                                                  if(page=="food"){
                                                    cartController.addItem(_cartList[index].product!,1, date , time);
                                                  }else{
                                                    showCustomSnackBar("you can't add");
                                                  }
                                                },
                                                child: Icon(Icons.add , color: AppColors.signColor,size: Dimensions.font20,),
                                              ),
                                            ],
                                          ),
                                        ),
                
                                      ],
                                    ),
                                  ],
                                ),
                              ), 
                            ),
                          ],
                        ),
                      );
              });
                },),
                ),
                ),
          ):NoDataPage(text: "Your cart is empty!");
        
          }),
          ],
      ),
        bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(top: Dimensions.height30 , bottom: Dimensions.height30 , left: Dimensions.width20 , right: Dimensions.width20),
            decoration: BoxDecoration(
              color : AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius20*2),
                topLeft: Radius.circular(Dimensions.radius20*2),
              ),
            ),
            child: cartController.getItems.length>0?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20 , bottom: Dimensions.height20 , left: Dimensions.width20 , right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                child: Row(
                  children: [
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text:cartController.totalAmount.toString()+ " DA" ,size: Dimensions.font16,),
                    SizedBox(width: Dimensions.width10/2,),
                  ],
                ),
                ),
                GestureDetector(
                  onTap:(){
                    
                     if(verification()){
                      if(page=="food"){
                      _registertion(cartController);
                      }else{
                        Get.toNamed(RouteHelper.getInitial());
                      }
                     }else{
                      Get.toNamed(RouteHelper.getCalResPage());
                     }
                    
                    },
                  child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20 , bottom: Dimensions.height20 , left: Dimensions.width20 , right: Dimensions.width20),
                    
                    child: BigText(text: " Check out " , color: Colors.white,size: Dimensions.font15,
                    ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                ),
                )
              ],
            ):Container(),
            );
        },),
    
    );
  }
}