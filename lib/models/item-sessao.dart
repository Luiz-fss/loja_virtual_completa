class ItemSessao{

  String? image;
  String? product;

  ItemSessao.fromMap(Map<String,dynamic>map){
    image = map["image"] as String;
    product = map["product"] as String;
  }

}