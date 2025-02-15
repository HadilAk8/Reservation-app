import 'package:flutter/material.dart';
import 'package:test/pages/home/food_page_body.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/dimensions.dart';
import 'package:test/widgets/big_text.dart';
import 'package:test/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key:key) ;

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //showing the header
           Container(
      child: Container(
        margin: EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.height15), 
        padding: EdgeInsets.only(left: Dimensions.width20 , right: Dimensions.width20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween ,
          children: [
            Column(
              children: [
                BigText(text: "Restaurant", color: AppColors.mainColor),
                Row(
                  children: [
                    SmallText(text: "Algeria" , color: Colors.black),
                    Icon(Icons.arrow_drop_down_rounded)
                  ],
                )
              ],
            ),
            Center(
              child: Container(
              width: Dimensions.height45,
              height: Dimensions.height45,
              child: Icon(Icons.table_bar,color: Colors.white, size: Dimensions.iconsize24,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                color: AppColors.mainColor,
              ) ,
            ),
            )
          ],
        ),
      ),
    ),
           //showing the body
           Expanded(child: SingleChildScrollView(
            child: FoodPageBody(),
            )),
           
      ],)
    );
  }
}