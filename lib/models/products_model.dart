class Product {
  // ignore: unused_field
  int? _totalSize;
  // ignore: unused_field
  int? _typeId;
  // ignore: unused_field
  int? _offset;
  late List<ProductModel> _products;
  List<ProductModel> get  products => _products;

  Product({required totalSize, required typeId, required offset, required products}){
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset = offset;
    this._products = products;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        _products.add(ProductModel.fromJson(v));
      });
    }
  }
}

class ProductModel {
  int? id;
  String? nomP;
  int? typeId;
  int? price;
  String? img;
  String? description;
  String? createdAt;
  String? updatedAt;

  ProductModel(
      {this.id,
      this.nomP,
      this.typeId,
      this.price,
      this.img,
      this.description,
      this.createdAt,
      this.updatedAt});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomP = json['nomP'];
    typeId = json['type_id'];
    price = json['price'];
    img = json['img'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String , dynamic> toJson(){
    return{
    "id":this.id,
    "name":this.nomP,
    "type_id":this.typeId,
    "price":this.price,
    "img":this.img,
    "createdAt":this.createdAt,
    "updatedAt":this.updatedAt,
    
    };
  }

}