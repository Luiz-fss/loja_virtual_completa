class SectionItem{

  dynamic image;
  String? product;

  SectionItem.fromMap(Map<String,dynamic>map){
    image = map["image"];
    product = map["product"];
  }

  SectionItem({this.product,this.image}){}

  SectionItem clone (){
    return SectionItem(
      image: image,
      product: product
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "image":image,
      "product":product
    };
  }
}