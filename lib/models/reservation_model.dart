class ReservationModel {
  String? dateR;
  String? timeR;
  int? idTable;
  int? idUser;
  int? idCart;


  ReservationModel({
    this.dateR,
    this.timeR,
    this.idTable,
    this.idUser,
    this.idCart
  });
  ReservationModel.fromJson(Map<String, dynamic> json) {
    dateR = json['dateR'];
    timeR = json['Time'];
    idTable = json['idTable'];
    idUser = json['idClient'];
    idCart = json['idC'];
  }
  Map<String , dynamic> toJson(){
    Map<String , dynamic> data = new Map<String, dynamic>();
    data["dateR"] = this.dateR ;
    data["Time"] = this.timeR;
    data["idTable"] = this.idTable;
    data["idClient"] = this.idUser;
    data["idC"] = this.idCart;
    return data;
  }
}

