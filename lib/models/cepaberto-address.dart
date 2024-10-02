class CepAbertoAddress {
  double? altitude;
  String? cep;
  double? latitude;
  double? longitude;
  String? logradouro;
  String? bairro;
  Cidade? cidade;
  Estado? estado;

  CepAbertoAddress({this.cep,
     this.longitude,
    this.latitude,
    this.altitude,
    this.cidade,
    this.estado,
    this.bairro,
    this.logradouro});

  CepAbertoAddress fromJson(Map<String, dynamic> map) {
    return CepAbertoAddress(
        altitude: map["altitude"],
        cep: map["cep"],
        latitude: double.tryParse(map["latitude"]),
        longitude: double.tryParse(map["longitude"]),
        logradouro: map["logradouro"],
        bairro: map["bairro"],
        cidade: Cidade().fromJson(map["cidade"]),
        estado: Estado().fromJson(map["estado"]));
  }
}

class Cidade {
  int? ddd;
  String? ibge;
  String? nome;

  Cidade({this.nome, this.ddd, this.ibge});

  Cidade fromJson(Map<String, dynamic> map) {
    return Cidade(ddd: map["ddd"], ibge: map["ibge"], nome: map["nome"]);
  }
}

class Estado {
  String? sigla;

  Estado({this.sigla});
  Estado fromJson(Map<String, dynamic> map) {
    return Estado(sigla: map["sigla"]);
  }
}
