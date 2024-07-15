import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test/base/show_custom_snackbar.dart';
import 'package:test/controllers/cart_controller.dart';
import 'package:test/controllers/reservation_controller.dart';
import 'package:test/controllers/table_res_controller.dart';
import 'package:test/controllers/user_controller.dart';
import 'package:test/models/cart_model.dart';
import 'package:test/models/reservation_model.dart';
import 'package:test/models/table_model.dart';
import 'package:test/pages/Archi_tables/Archi1_page.dart';
import 'package:test/pages/Archi_tables/Archi2_page.dart';
import 'package:test/pages/Archi_tables/Archi3_page.dart';
import 'package:test/routes/route_helper.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/dimensions.dart';
import 'package:test/widgets/app_icon.dart';
import 'package:test/widgets/big_text.dart';
import 'package:test/widgets/small_text.dart';



class TableResPage extends StatefulWidget {
  const TableResPage({super.key});

  @override
  State<TableResPage> createState() => _TableResPageState();
}

class _TableResPageState extends State<TableResPage> {
  String _selectedButton = 'Button 1';
  int _selectInd = 0;
  List pages=[
    Archi1Page(),
    Archi2Page(),
    Archi3Page(),
  ];
  

  void _changeContent(String buttonText) {
    setState(() {
      _selectedButton = buttonText;
      if (buttonText == 'Button 1') {
        _selectInd=0;
      } else if (buttonText == 'Button 2') {
        _selectInd=1;
      } else {
        _selectInd=2;
      }
    });
  }
  late String selectedTable='';
  String? date;
  String? time;
  TableModel? table;
  var arg = Get.arguments as Map;
    
  @override
  void initState() {
    super.initState();
    date = arg["date"];
    time = arg["Time"];
  }
  @override
  Widget build(BuildContext context) {
    void _registertion(ReservationController reservationController){

    String? dateR = date ;
    String? timeR = time;
    int idU = Get.find<UserController>().userModel.id as int;
    print("id user is"+idU.toString());
    List<Map<String,int>> item=[];
      Map<String,int> regCart= {"idP":0 , "quantity":0};
      List<int> keysList = Get.find<CartController>().items.keys.toList();
      for (var key in keysList) {
      
      CartModel? cartItem = Get.find<CartController>().items[key];
    
      regCart = {
        "idP": cartItem?.id as int, 
        "quantity": cartItem?.quantity as int
      };

    item.add(regCart);
  }
  Map<String ,List<Map<String,int>>> data = {"items":item};
  Get.find<CartController>().registration(data).then((status){
          if(status.isSuccess){
            print("Success registration Cart");
            Get.find<CartController>().addToHistory(dateR! , timeR!);
            
          }else{
            print("error cart");
            showCustomSnackBar(status.message);
          }
        });
    int idC = Get.find<CartController>().cartElement as int;
    print("id cart is"+idC.toString());
    print(table?.id);
    ReservationModel reservationModel = ReservationModel(timeR: timeR , dateR: dateR?.substring(0,10) , idTable: table?.id , idUser: idU , idCart: idC+1) ;
    reservationController.registration(reservationModel).then((status){
      print("we do reservation now");
          if(status.isSuccess){
            print("Success registration Table");
            Get.offNamed(RouteHelper.getConfarmationPage() , arguments : {"table" : table});
            Get.find<CartController>().getCartElement();
          }else{
            print("error reservation");
            showCustomSnackBar(status.message);
            print(status.message);
          }
        });
        Get.find<CartController>().clear();
  }
    return GetBuilder<ReservationController>(
      builder: (reservation) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            shadowColor: Colors.white,
            automaticallyImplyLeading: false,
            title:Container(
                  
                      margin: EdgeInsets.only(top: Dimensions.height45 , left: Dimensions.width15 , bottom: Dimensions.height30*2),
                      child: Row(
                        
                        children: [
                          
                          GestureDetector(
                            onTap: () {
                              reservation.setTableName("");
                              Get.toNamed(RouteHelper.getCalResPage());
                            },
                            child: Container(
                              height: Dimensions.height20*2 ,
                              width: Dimensions.width20*2,
                              decoration: BoxDecoration(
                              color: AppColors.buttonBackgroundColor,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: AppIcon(icon: Icons.arrow_back,),
                            ),
                          ),
                          SizedBox(width: Dimensions.width20*3,),
                          BigText(text: "Book a Table")
                        ],
                      ),
                    ),    
            ),
          body: Column(
            children: [
              Container(
                  height: Dimensions.height45*2,
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector( onTap: () => _changeContent('Button 1'),
                        child: Container(
                          padding: EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              SmallText(
                                  text: "1st Floor",
                                  color: AppColors.titleColor,
                                ),
                                SizedBox(height: 5,),
                                _selectedButton == 'Button 1'?Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5) ,
                                      topRight: Radius.circular(5) ,
                                    ),
                                  ),
                                  height: 3.0,
                                  width: 60.0, // Adjust width as needed
                                ):Container(),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector( onTap: () => _changeContent('Button 2'),
                        child: Container(
                          padding: EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              SmallText(
                                  text: "2st Floor",
                                  color: AppColors.titleColor,
                                ),
                                SizedBox(height: 5,),
                                _selectedButton == 'Button 2'?Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5) ,
                                      topRight: Radius.circular(5) ,
                                    ),
                                  ),
                                  height: 3.0,
                                  width: 60.0, // Adjust width as needed
                                ):Container(),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector( onTap: () => _changeContent('Button 3'),
                        child: Container(
                          padding: EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              SmallText(
                                  text: "3st Floor",
                                  color: AppColors.titleColor,
                                ),
                                SizedBox(height: 5,),
                                _selectedButton == 'Button 3'?Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5) ,
                                      topRight: Radius.circular(5) ,
                                    ),
                                  ),
                                  height: 3.0,
                                  width: 60.0, // Adjust width as needed
                                ):Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: Dimensions.height10,
                            width: Dimensions.width10,
                            margin: EdgeInsets.only(right: Dimensions.width10/2),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius15)),
                            ),
                          ),
                          SmallText(text: "Reserved",color: AppColors.titleColor,),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: Dimensions.height10,
                            width: Dimensions.width10,
                            margin: EdgeInsets.only(right: Dimensions.width10/2),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius15)),
                            ),
                          ),
                          SmallText(text: "Available",color: AppColors.titleColor,),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: Dimensions.height10,
                            width: Dimensions.width10,
                            margin: EdgeInsets.only(right: Dimensions.width10/2),
                            decoration: BoxDecoration(
                              color: AppColors.bluev,
                              borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius15)),
                            ),
                          ),
                          SmallText(text: "Selected",color: AppColors.titleColor,),
                        ],
                      ),
                    ],
                  ),
                ),
              pages[_selectInd],
              GetBuilder<TableResController>(
                builder: (tables) {
                  return Expanded(
                      child: Container(
                      margin : EdgeInsets.only(top: Dimensions.height15),
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
                          selectedTable = reservation.tableName;
                          table = tables.findTableList(selectedTable);
                          if(Get.find<UserController>().isLoading){
                            if(selectedTable==""){
                            Get.snackbar("Error", "Please select a table",backgroundColor: Colors.redAccent , colorText: Colors.white);
                            }else{
                              if(Get.find<CartController>().items.isNotEmpty){
                                _registertion(reservation);
                                print(selectedTable.toString() + date.toString() + time.toString() );
                                print(table!.toJson()); 
                              }else{
                                Get.toNamed(RouteHelper.getMenuPage());
                              }
                            }
                          }else{
                            showCustomSnackBar("You have to Sign in");
                          }
                          
                        },
                        child: Container(
                              
                              margin: EdgeInsets.only(left:45,right: 45 , top: 20, bottom: 20),
                              padding: EdgeInsets.only(left: Dimensions.width10*8,top:Dimensions.height10),
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.radius20*2),
                                ),
                              ),
                              child: BigText(text: "Reserve Table",color: Colors.white,),
                            ),
                      )),
                    );
                }
              ),
              
            ],
          ),
          
        );
      }
    );
  }
  
}