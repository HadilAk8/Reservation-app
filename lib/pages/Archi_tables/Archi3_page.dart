import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/base/show_custom_snackbar.dart';
import 'package:test/controllers/reservation_controller.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/dimensions.dart';
import 'package:test/widgets/big_text.dart';

class Archi3Page extends StatefulWidget {
  const Archi3Page({super.key});

  @override
  State<Archi3Page> createState() => _Archi3PageState();
}

class _Archi3PageState extends State<Archi3Page> {
  String? selectedTable;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.height15),
      height: Dimensions.height45 * 10,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTable("C6" , "assets/image/Table4.jpg" , Dimensions.height30*2 , Dimensions.height20*2),
                buildTable("C5" , "assets/image/Table4.jpg" , Dimensions.height30*2 , Dimensions.height20*2),
              ],
            ), 
            SizedBox(height: 15),
            buildTable("C4" , "assets/image/roundTable6.jpg" , Dimensions.height15*5+3 , Dimensions.height15*5),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTable("C3" , "assets/image/Table4.jpg" , Dimensions.height30*2 , Dimensions.height20*2),
                buildTable("C2" , "assets/image/Table4.jpg" , Dimensions.height30*2 , Dimensions.height20*2),
              ],
            ), 
            SizedBox(height: 15),
            buildTable("C1" , "assets/image/roundTable6.jpg" , Dimensions.height15*5+3 , Dimensions.height15*5),
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