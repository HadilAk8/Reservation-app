
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test/base/no_data_page.dart';
import 'package:test/controllers/cart_controller.dart';
import 'package:test/models/cart_model.dart';
import 'package:test/routes/route_helper.dart';
import 'package:test/utils/app_constants.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/dimensions.dart';
import 'package:test/widgets/app_icon.dart';
import 'package:test/widgets/big_text.dart';
import 'package:test/widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder =Map();

    for(int i=0;i<getCartHistoryList.length;i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!,(value)=>++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!,()=>1);
      }
    }

    List<int> cartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList() ;
    
    var listCounter=0;
    return Scaffold(

      body: Column(
        children: [
          Container(
            height: Dimensions.height10*10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45 , left: Dimensions.width15 , right: Dimensions.width15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(text: "Cart History",color: Colors.white,),
                AppIcon(icon:Icons.shopping_cart_outlined ,
                 iconColor: Colors.white,
                 backgroundColor: AppColors.mainColor,
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getCartHistoryList().length>0?Expanded(
            child: Container(
              margin: EdgeInsets.only(top:Dimensions.height20, left: Dimensions.width20 , right: Dimensions.width20),
              child: MediaQuery.removePadding(
               removeTop: true,
               context: context,
               child: ListView(
            
                children: [
                  for(int i=0; i<itemsPerOrder.length ;i++)
                   Container(
                    height: Dimensions.height30*4,
                    margin: EdgeInsets.only(bottom: Dimensions.height20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            BigText(text: getCartHistoryList[listCounter].date!.substring(0,10)),
                            SizedBox(width: Dimensions.width10,),
                            BigText(text: getCartHistoryList[listCounter].time!),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              direction: Axis.horizontal,
                              children: List.generate(itemsPerOrder[i], (index){
                                if(listCounter<getCartHistoryList.length){
                                  listCounter++;
                                }
                                return index<=2?Container(
                                  height: Dimensions.height10*7,
                                  width: Dimensions.height10*7,
                                  margin: EdgeInsets.only(right: Dimensions.width10/2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        AppConstant.BASE_URL+AppConstant.UPLOAD_URL+getCartHistoryList[listCounter-1].img!
                                      ),
                                    ),
                                  ),
                                ):Container();
                                }),
                            ),
                            Container(
                              height: Dimensions.height10*7,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SmallText(text: "Total",color: AppColors.titleColor,),
                                  BigText(text: itemsPerOrder[i].toString()+"Items",color: AppColors.titleColor,),
                                  GestureDetector(
                                    onTap: () {
                                      var orderTime = cartOrderTimeToList();
                                      Map<int , CartModel> moreOrder ={};
                                      for(int j=0; j<getCartHistoryList.length;j++){
                                        if(getCartHistoryList[j].time==orderTime[i]){
                                          moreOrder.putIfAbsent(getCartHistoryList[j].id!, () => 
                                            CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                          );
                                        }
                                      }
                                      Get.find<CartController>().setItems = moreOrder;
                                      Get.find<CartController>().addToCartList();
                                      Get.toNamed(RouteHelper.getCartPage("cart"));
                                    },
                                    child:Container(
                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 , vertical: Dimensions.height10/2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                        border: Border.all(width: 1 , color: AppColors.mainColor),
                                      ),
                                      child: SmallText(text: "one more",color: AppColors.mainColor,),
                                    ),
                                  ),
                                 ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                   ),
                ],
              ),
            
               ),
              ),
          ):SizedBox(
            height: MediaQuery.of(context).size.height/1.5,
            child: const Center(
              child: NoDataPage(text: "You didn't reserve nothing so far !"
              ),
            ),
          );
        
          })
          ],
      ),
    );
  }
}