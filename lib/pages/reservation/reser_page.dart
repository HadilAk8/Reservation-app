import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/routes/route_helper.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/dimensions.dart';
import 'package:test/widgets/app_icon.dart';
import 'package:test/widgets/big_text.dart';
import 'package:test/widgets/small_text.dart';

class ResarvationPage extends StatelessWidget {
  ResarvationPage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.height10 * 20,
            width: double.maxFinite,
            padding: EdgeInsets.only(
                top: Dimensions.height30*3,
                left: Dimensions.width30,
                right: Dimensions.width15),
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Dimensions.radius20 * 2),
                bottomRight: Radius.circular(Dimensions.radius20 * 2),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), // Shadow color
                  spreadRadius: 1, // Spread radius
                  blurRadius: 10, // Blur radius
                  offset: Offset(0, 5), // Changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppIcon(icon: Icons.radar , backgroundColor: AppColors.mainColor, iconColor: Colors.white,size: Dimensions.font24,),
                    BigText(
                      text: "Welcome to our restaurant",
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height20),
                Container(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: SmallText(
                    text: "You can reserve your table and your plate easily!!",
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: "Details", size: Dimensions.font26),
                  SizedBox(height: Dimensions.height20),
                  Text(
                    "We are delighted to have you join us today. Our team is dedicated to providing you with an exceptional dining experience, filled with delicious food, refreshing beverages, and a warm, inviting atmosphere.",
                    style: TextStyle(fontSize: Dimensions.font16),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(height: Dimensions.height10),
                  Text(
                    "Whether you're here for a special celebration, a casual meal, or just a quick bite, we have something for everyone. Our menu features a variety of dishes crafted from the freshest ingredients, and our staff is here to ensure you have a memorable time.",
                    style: TextStyle(fontSize: Dimensions.font16),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(height: Dimensions.height10),
                  Text(
                    "If you have any special requests or need any assistance, don't hesitate to reach out.",
                    style: TextStyle(fontSize: Dimensions.font16),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: "Happy dining!", size: Dimensions.font20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.height45*4,
        width: double.maxFinite,
        padding: EdgeInsets.only(
            left: Dimensions.width15 * 2,
            top: Dimensions.height15 * 4,
            right: Dimensions.width15 * 2,
            bottom: Dimensions.height15 * 4),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius20 * 2),
            topRight: Radius.circular(Dimensions.radius20 * 2),
          ),
          boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), // Shadow color
                  spreadRadius: 1, // Spread radius
                  blurRadius: 10, // Blur radius
                  offset: Offset(0, 5), // Changes position of shadow
                ),
              ],
        ),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getCalResPage());
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.radius20 * 2),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), // Shadow color
                  spreadRadius: 1, // Spread radius
                  blurRadius: 10, // Blur radius
                  offset: Offset(0, 5), // Changes position of shadow
                ),
              ],
            ),
            
            child: Center(
              child: BigText(
                text: "Book now",
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}