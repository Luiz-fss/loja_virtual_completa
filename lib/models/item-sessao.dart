class ItemSessao{

  String? image;

  ItemSessao.fromMap(Map<String,dynamic>map){
    image = map["image"] as String;
  }

}