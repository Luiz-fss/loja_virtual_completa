class ItemSessao{

  dynamic image;
  String? product;

  ItemSessao({this.image,this.product});
  ItemSessao.fromMap(Map<String,dynamic>map){
    image = map["image"] as String?;
    product = map["product"] as String?;
  }

  ItemSessao clone (){
    return ItemSessao(
      image: image,
      product: product
    );
  }

}