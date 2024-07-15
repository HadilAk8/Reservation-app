import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:test/controllers/reservation_controller.dart';
import 'package:test/controllers/table_res_controller.dart';
import 'package:test/controllers/user_controller.dart';
import 'package:test/routes/route_helper.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/dimensions.dart';
import 'package:test/widgets/app_icon.dart';
import 'package:test/widgets/big_text.dart';
import 'package:test/widgets/small_text.dart';

// ignore: must_be_immutable
class ConfarmationPage extends StatelessWidget {
  ConfarmationPage({super.key});

  var arg = Get.arguments as Map ;
  String email = Get.find<UserController>().userModel.email;
  String name = Get.find<UserController>().userModel.name;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ReservationController>(
        builder: (context) {
          return Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height20*5),
                  height: Dimensions.height30*5,
                  width: Dimensions.width30*5,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20*15)),
                  ),
                  child: AppIcon(icon: Icons.check , size:Dimensions.height30*5,iconColor: Colors.white,backgroundColor: AppColors.mainColor,iconSize:  Dimensions.height20*5,),
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              BigText(text: "Successfully"),
              BigText(text: "Reserved Your Table!"),
              SizedBox(height: Dimensions.height45,),
              Container(
                margin: EdgeInsets.only(left: Dimensions.width15*2 ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: "Name: ", color: AppColors.mainColor, size: Dimensions.font20,),
                            SizedBox(height: Dimensions.height15,),
                            SmallText(text: name),
                          ],
                        ),
                        SizedBox(width: Dimensions.width30*5,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: "Email: ", color: AppColors.mainColor, size:  Dimensions.font20,),
                            SizedBox(height: Dimensions.height15,),
                            SmallText(text: email),
                          ],
                        ),
                        
                      ],
                    ),
                    SizedBox(height: Dimensions.height15,),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: "Date: ", color: AppColors.mainColor, size:  Dimensions.font20,),
                            SizedBox(height: Dimensions.height15,),
                            SmallText(text: context.date.substring(0,10)),
                          ],
                        ),
                        SizedBox(width: Dimensions.width30*5,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: "Time: ", color: AppColors.mainColor, size:  Dimensions.font20,),
                            SizedBox(height: Dimensions.height15,),
                            SmallText(text: context.time),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.height15,),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: "Name table: ", color: AppColors.mainColor, size:  Dimensions.font20,),
                            SizedBox(height: Dimensions.height15,),
                            SmallText(text: arg["table"].nameT.toString()),
                          ],
                        ),
                        SizedBox(width: Dimensions.width30*3,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: "floor: ", color: AppColors.mainColor, size:  Dimensions.font20,),
                            SizedBox(height: Dimensions.height15,),
                            SmallText(text:arg["table"].floor.toString()),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      ),
      bottomNavigationBar:Expanded(
                  child: Container(
                  margin : EdgeInsets.only(top: Dimensions.height15),
                  height: Dimensions.height30*5,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: AppColors.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20*2),
                      topRight: Radius.circular(Dimensions.radius20*2),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.find<ReservationController>().setTableName("");
                      Get.find<TableResController>().getTableList();
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: Container(
                          margin: EdgeInsets.only(left:Dimensions.height45,right:Dimensions.height45  , top: Dimensions.height45, bottom: Dimensions.height45),
                          padding: EdgeInsets.only(left: Dimensions.width10*6,top:Dimensions.height15),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius20*2),
                            ),
                          ),
                          child: BigText(text: "Go Back to Home",color: Colors.white,),
                        ),
                  )),
                ),
    );
  }
}