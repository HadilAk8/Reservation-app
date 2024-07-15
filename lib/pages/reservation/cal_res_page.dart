import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:test/controllers/reservation_controller.dart';
import 'package:test/pages/reservation/time_page.dart';
import 'package:test/routes/route_helper.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/dimensions.dart';
import 'package:test/widgets/app_icon.dart';
import 'package:test/widgets/big_text.dart';


// ignore: must_be_immutable
class CalResPage extends StatefulWidget{
  CalResPage({Key? key}) : super(key:key);
  
@override
  State<CalResPage> createState() => _CalResPageState();
}

class _CalResPageState extends State<CalResPage> {
  @override
  Widget build(BuildContext context) {
    List<DateTime?> _dates =List.empty() ;
    String debutTime ="";
    bool reservationCont(List<DateTime?> date ,String time){
      if(date.length==0 ){
        Get.snackbar("Date Reservation","You should choose a date", backgroundColor: Colors.redAccent , colorText: Colors.white);
      }else{
        if(time==""){
          Get.snackbar(" Time Reservation","You should choose a Time", backgroundColor: Colors.redAccent , colorText: Colors.white);
        }else{
          DateTime currentDate = DateTime.now();
          DateTime currentDateDateOnly = DateTime(currentDate.year, currentDate.month, currentDate.day);
          if(date[0]!.isAtSameMomentAs(currentDateDateOnly)){
            TimeOfDay currentTime = TimeOfDay.now(); 
              List<String> comparisonTimeParts = time.split(':');
              TimeOfDay comparisonTime = TimeOfDay(
                hour: int.parse(comparisonTimeParts[0]),
                minute: int.parse(comparisonTimeParts[1]),
              );

              if (currentTime.hour > comparisonTime.hour ||
                  (currentTime.hour == comparisonTime.hour && currentTime.minute > comparisonTime.minute)) {
                Get.snackbar("Time Reservation","invalide Time", backgroundColor: Colors.redAccent , colorText: Colors.white);
              } else {
                return true;
              }
          }
          else{
            if(date[0]!.isBefore(DateTime.now())){
              Get.snackbar("Date Reservation","invalide Date", backgroundColor: Colors.redAccent , colorText: Colors.white);
            }else{
              return true;
            }
          }
        }
      }
      return false;
    }
    return Scaffold(
      body:Stack(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 0),
            margin: EdgeInsets.only(top: Dimensions.height15*2 , bottom: 0),
            child: GetBuilder<ReservationController>(
              builder: (_reservController) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: Dimensions.height10*2 , left: Dimensions.width15 , bottom: Dimensions.height10*2),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getInitial());
                            },
                            child: Container(
                              height: Dimensions.height20*2 ,
                              width: Dimensions.width20*2,
                              decoration: BoxDecoration(
                              color: AppColors.buttonBackgroundColor,
                              borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20)),
                            ),
                            child: AppIcon(icon: Icons.arrow_back,),
                            ),
                          ),
                          SizedBox(width: Dimensions.width20*3,),
                          BigText(text: "Book a Table")
                        ],
                      ),
                    ),
                    Container(padding: EdgeInsets.only(left: Dimensions.width20), child: BigText(text: "Date", color: AppColors.titleColor,)),
                    CalendarDatePicker2(
                      config: CalendarDatePicker2Config(
                        selectedDayHighlightColor: AppColors.mainColor,
                      ),
                      value: _dates,
                      onValueChanged: (dates) => _dates = dates,
                    ),
                    Container(padding: EdgeInsets.only(left: Dimensions.width20) , child: BigText(text: "Time", color: AppColors.titleColor,)),
                    TimePage(),
                    GetBuilder<ReservationController>(
                      builder: (reservation) {
                        return Expanded(
                          child: Container(
                          margin : EdgeInsets.only(top: Dimensions.height15*2),
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
                              debutTime = reservation.time;
                              if(reservationCont(_dates, debutTime)==true){
                                print(_dates[0].toString().substring(0,10));
                                if(reservation.existeTables(_dates[0].toString(),debutTime)==true){
                                  reservation.passDate(_dates[0].toString().substring(0,10));
                                  Get.toNamed(RouteHelper.getTableResPage() , arguments: {"date" : _dates[0].toString().substring(0,10) , "Time": debutTime} );
                                }else{
                                  Get.snackbar("Error", "tout les tables sont déjà réservée pour cette date et heure",backgroundColor: Colors.redAccent);
                                }
                              }
                            },
                            child: Container(
                                  margin: EdgeInsets.only(left:Dimensions.height45,right: Dimensions.height45 , top:Dimensions.height20, bottom: Dimensions.height20),
                                  //margin: EdgeInsets.all(Dimensions.height15*2),
                                  padding: EdgeInsets.only(left: Dimensions.width96,top:Dimensions.height13),
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Dimensions.radius20*2),
                                    ),
                                  ),
                                  child: BigText(text: "Continue",color: Colors.white,),
                                ),
                          )),
                        );
                      }
                    ),
                  ],
                );
              }
            ),
          
          ),
        ],
      ),
    );
    
  }
  

}