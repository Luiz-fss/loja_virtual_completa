class TamanhoItem {

  String? nome;
  num? preco;
  int? stock;

  TamanhoItem.fromMap(Map<String,dynamic> map){
    nome = map["name"] as String;
    preco = map["price"] as num;
    stock = map["stock"] as int;
  }

  bool get temStock => stock! > 0;
  @override
  String toString() {
    return 'TamanhoItem{nome: $nome, preco: $preco, stock: $stock}';
  }

}