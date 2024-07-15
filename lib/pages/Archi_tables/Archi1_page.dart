import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/base/show_custom_snackbar.dart';
import 'package:test/controllers/reservation_controller.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/dimensions.dart';
import 'package:test/widgets/big_text.dart';

class Archi1Page extends StatefulWidget {
  const Archi1Page({super.key });

  @override
  State<Archi1Page> createState() => _Archi1PageState();
}

class _Archi1PageState extends State<Archi1Page> {
  String? selectedTable;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.height15),
      height: Dimensions.height45 * 10,
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildTable("A10" , "assets/image/Table8.jpg" ,Dimensions.height15*5+3 , Dimensions.height10*11),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTable("A9" , "assets/image/Table2.jpg" , Dimensions.height30*2 , Dimensions.height30),
                buildTable("A8" , "assets/image/roundTable4.jpg" , Dimensions.height10*6 , Dimensions.height10*5+2),
                buildTable("A7" , "assets/image/Table2.jpg" , Dimensions.height30*2 , Dimensions.height30),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTable("A6" , "assets/image/Table2.jpg" , Dimensions.height30*2 , Dimensions.height30),
                buildTable("A5" , "assets/image/roundTable4.jpg" , Dimensions.height10*6 , Dimensions.height10*5+2),
                buildTable("A4" , "assets/image/Table2.jpg" , Dimensions.height30*2 , Dimensions.height30),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTable("A3" , "assets/image/Table2.jpg" , Dimensions.height30*2 , Dimensions.height30),
                buildTable("A2" , "assets/image/roundTable4.jpg" , Dimensions.height10*6 , Dimensions.height10*5+2),
                buildTable("A1" , "assets/image/Table2.jpg" , Dimensions.height30*2 , Dimensions.height30),
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
                  color: reservation.tableValide(tableName,reservation.date,reservation.time)?isSelected ? AppColors.bluev : AppColors.mainColor:Colors.redAccent,
                ),
              ),
            ],
          ),
        );
      }
    );
    
  }

  

}