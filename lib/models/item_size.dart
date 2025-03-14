class ItemSize {

  String? name;
  num? price;
  int? stock;

  ItemSize({this.name,this.price,this.stock}){}

  bool get hasStock => stock! > 0;

  ItemSize.fromMap(Map<String,dynamic> map){
    name = map["name"];
    price = map["price"];
    stock = map["stock"];
  }

  Map<String,dynamic> toMap(){
    return  {
      "name":name,
      "price":price,
      "stock":stock
    };
  }

  ItemSize clone (){
    return ItemSize(
      name: name,
      price: price,
      stock: stock
    );
  }
}