import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/base/show_custom_snackbar.dart';
import 'package:test/controllers/reservation_controller.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/dimensions.dart';
import 'package:test/widgets/big_text.dart';

class Archi2Page extends StatefulWidget {
  const Archi2Page({super.key});

  @override
  State<Archi2Page> createState() => _Archi2PageState();
}

class _Archi2PageState extends State<Archi2Page> {
  String? selectedTable;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.height15),
      height: Dimensions.height45 * 10,
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildTable("B6" , "assets/image/Table8.jpg" , Dimensions.height15*5+3 , Dimensions.height10*11),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTable("B5" , "assets/image/Table6.jpg" , Dimensions.height30*2 , Dimensions.height30*2),
                buildTable("B4" , "assets/image/Table6.jpg" , Dimensions.height30*2 , Dimensions.height30*2),
              ],
            ), 
            SizedBox(height: 15),
            buildTable("B3" , "assets/image/roundTable6.jpg" , Dimensions.height15*5+2 , Dimensions.height15*5),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTable("B2" , "assets/image/roundTable4.jpg" , Dimensions.height5*11 , Dimensions.height10*5),
                buildTable("B1" , "assets/image/roundTable4.jpg" ,Dimensions.height5*11 , Dimensions.height10*5+2),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTable(String tableName , String image , double topT , double leftT) {
    bool isSelected = selectedTable == tableName;

    return GetBuilder<ReservationController>(
      builder: (reservation) {
        return GestureDetector(
          onTap: () {
             if(reservation.tableValide(tableName,reservation.date,reservation.time)){
              setState(() {
                selectedTable = tableName;
              });
              reservation.passTableName(selectedTable.toString());
                
            }else{
              showCustomSnackBar("The Table already reserved");
            }
          },
          child: Stack(
            children: [
              Image.asset(image),
              Positioned(
                top: topT,
                left: leftT,
                child: BigText(
                  text: tableName,
                  color: reservation.tableValide(tableName,reservation.date,reservation.time)==true?isSelected ? AppColors.bluev : AppColors.mainColor:Colors.redAccent,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}