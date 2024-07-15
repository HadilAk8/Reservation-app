
class TableModel {
  int? id;
  String? nameT;
  int? nbPlace;
  int? floor;

  TableModel({
    this.id,
    this.nameT,
    this.nbPlace,
    this.floor,
  });

  TableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameT = json['nomT'];
    nbPlace = json['nbP'];
    floor = json['floor'];
  }

  Map<String , dynamic> toJson(){
    return{
      "id":this.id,
      "nameT":this.nameT,
      "nbPlace":this.nbPlace,
      "floor":this.floor,
    };
  }
}