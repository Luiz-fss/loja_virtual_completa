class CepAbertoAddress {
  final double? altitude;
  final String? cep;
  final double? latitude;
  final double? longitude;
  final String? logradouro;
  final String? bairro;
  final Cidade? cidade;
  final Estado? estado;

  CepAbertoAddress.fromJson(Map<String,dynamic> map):
        altitude = double.tryParse(map["altitude"] as String),
        cep =  map["cep"] as String,
        latitude =  double.tryParse(map["latitude"] as String),
        longitude = double.tryParse( map["longitude"] as String),
        logradouro = map["logradouro"] as String,
        bairro =  map["bairro"] as String,
        cidade = Cidade.fromJson(map["cidade"] as Map<String,dynamic>),
        estado = Estado.fromJson(map["estado"] as Map<String,dynamic>);

}

class Cidade{

  final int? ddd;
  final String? ibge;
  final String? nome;

  Cidade.fromJson(Map<String,dynamic> map):
      ddd = map["ddd"] as int,
      ibge = map["ibge"] as String,
      nome = map["nome"] as String;
}

class Estado{

  final String? sigla;
  Estado.fromJson(Map<String,dynamic> map):
        sigla = map["ddd"]as String;
}