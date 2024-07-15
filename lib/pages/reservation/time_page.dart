import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:test/controllers/reservation_controller.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/dimensions.dart';
import 'package:test/widgets/small_text.dart';
import 'package:flutter/src/material/colors.dart';

class TimePage extends StatefulWidget {
  const TimePage({super.key});

  @override
  State<TimePage> createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  int selectedContainerIndex = -1;
  @override
  Widget build(BuildContext context) {
    int h = 9 ;
    int m = 30;
    String debutTime ="";
    int minC=0;
    bool change = false ;
    return GetBuilder<ReservationController>(
      builder: (reservation) {
        return Expanded(
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (items,index){
                              h=9+(index ~/2)+index;
                              if (m == 30 && change==false) {
                                m = 0;
                                h++;
                              }
                              return Row(
                                children: [
                                  for(int i=0 ; i<3 ; i++)
                                  ((){
                                    if(index==0 && i==0 ){
                                      h=9;
                                      m=0;
                                    }else{
                                    if(m==30){
                                      m=0;
                                      if(i != 0){
                                      h++;
                                      }
                                      change=false;
                                    }else{
                                      m=30;
                                      change=true;
                                    }
                                    }
                                    
                                    return Container(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedContainerIndex = index * 3 + i;
                                          });
                                          if((i+index)%2==0){
                                            minC=0;
                                          }else{
                                            minC=3;
                                          }
                                          if(index%2==0){
                                            if(i==2){
                                              debutTime=(9+(index ~/2)+index+1).toString()+":"+minC.toString()+"0";
                                            }else{
                                              debutTime=(9+(index ~/2)+index).toString()+":"+minC.toString()+"0";
                                            }
                                          }else{
                                            if(i==1 || i==2){
                                              debutTime=(9+(index ~/2)+index+1).toString()+":"+minC.toString()+"0";
                                            }else{
                                              debutTime=(9+(index ~/2)+index).toString()+":"+minC.toString()+"0";
                                            }
                                          }
                                          
                                          print(debutTime);
                                          reservation.passTime(debutTime);
                                            
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(left: Dimensions.width20 , right: Dimensions.width15 , top: Dimensions.height10 ),
                                          padding: EdgeInsets.only(left: Dimensions.width23 , top: Dimensions.height13),
                                          height: Dimensions.height10*4 ,
                                          width: Dimensions.width15*5,
                                          decoration: BoxDecoration(
                                            color: selectedContainerIndex == (index * 3 + i)? AppColors.mainColor: AppColors.buttonBackgroundColor,
                                            borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20)),
                                          ),
                                          child: m==0?SmallText(text:h.toString()+":"+"00",color:selectedContainerIndex != (index * 3 + i)?AppColors.titleColor:Colors.white,size: Dimensions.font13,):SmallText(text:h.toString()+":"+"30",color: selectedContainerIndex != (index * 3 + i)?AppColors.titleColor:Colors.white,size: Dimensions.font13,),
                                        ),
                                      ),
                                    );
                                    
                                  }()),
                                    
                                ],
                              );
                            } ,
                            ),
                        );
      }
    );
  }
}