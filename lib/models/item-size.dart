class ItemSize {

  String? name;
  num? price;
  int? stock;

  ItemSize({this.price,this.stock,this.name});

  ItemSize clone (){
    return ItemSize(
      price: price,
      name: name,
      stock: stock
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "name":name,
      "price": price,
      "stock":stock
    };
  }

  ItemSize.fromMap(Map<String,dynamic> map){
    name = map["name"] as String;
    price = map["price"] as num;
    stock = map["stock"] as int;
  }

  bool get hasStock => stock! > 0;
  @override
  String toString() {
    return 'TamanhoItem{nome: $name, preco: $price, stock: $stock}';
  }

}