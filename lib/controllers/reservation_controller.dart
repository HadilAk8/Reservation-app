import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:test/controllers/table_res_controller.dart';
import 'package:test/data/repository/reservation_repo.dart';
import 'package:test/models/reservation_model.dart';
import 'package:test/models/response_model.dart';

class ReservationController extends GetxController implements GetxService{
  final ReservationRepo reservationRepo ;

  ReservationController({required this.reservationRepo});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  List<dynamic> _reservationList = [];
  List<dynamic> get  reservationList => _reservationList;
  
  List<ReservationModel> _items=[];
  List<ReservationModel> get items => _items;

  String _tableName = "";
  String get tableName => _tableName;

  String _date ="";
  String get date => _date;

  String _time = "";
  String get time => _time;

  void setTableName(String value) {
    _tableName = value;
    update();  // Notify listeners
  }

  void passTableName(String tableName){
     _tableName = tableName;
  }

  

  void passDate(String date){
     _date = date;
  }
  void passTime(String time){
     _time = time;
  }

  Future<ResponseModel> registration (ReservationModel reservationModel) async {
    _isLoaded =true;
    update();
    Response response = await reservationRepo.registration(reservationModel);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      responseModel = ResponseModel(true, "do perfectly");
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoaded =true;
    update();
    return responseModel;
  }

  Future<void> getReservationList()async {
    Response response = await reservationRepo.getReservationList();
    if(response.statusCode==200){
      _reservationList=[];
      List<dynamic> jsonResponse = response.body;
     _reservationList = jsonResponse.map((reservationJson) => ReservationModel.fromJson(reservationJson)).toList();
      _isLoaded = true;
      update();
    }else{
      
  }
  }

  List<int> findTables( String date , String time){
    List<int>  listTables = [];
    for(var reservation in _reservationList){
      if(reservation.dateR == date && reservation.timeR == time){
        listTables.add(reservation.idTable!);
      }
  }
  return  listTables;
  }

  bool tableValide(String nameT, String date, String time) {
    List<int> listTables = findTables(date.substring(0,10), time);
    TableResController tableResController = Get.find<TableResController>();  // Initialize the controller
    for (int tableId in listTables) {
      var table = tableResController.findTableList(nameT);  // Assuming this method takes an ID and returns a table object
      if (table?.id == tableId) {
        return false;  // Table with the same name is found, return false
      }
    }

  return true;  // No table with the same name found, return true
}

  bool existeTables(String date, String time){
    List<int>   listTables = findTables(date.substring(0,10) , time);
    if (listTables.length == 22) {
      return false;
    }else{
      return true;
    }
  }

  void affiche(){
    _items.forEach((value) {
      print(value.dateR);
      print(value.timeR);
      print(value.idTable);
    });
  }
}