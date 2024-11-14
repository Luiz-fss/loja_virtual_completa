class Address {
  String? street;
  String? number;
  String? complement;
  String? district;
  String? city;
  String? state;
  double? lat;
  double? long;
  String? zipCode;

  Address(
      {this.state,
      this.city,
      this.complement,
      this.district,
      this.lat,
      this.long,
      this.number,
      this.street,
      this.zipCode});

  Map<String,dynamic> toMap(){
    return{
      "state":state,
      "city":city,
      "complement":complement,
      "district":district,
      "lat":lat,
      "long":long,
      "number":number,
      "street":street,
      "zipCode":zipCode
    };
  }

  static Address fromMap (Map<String,dynamic> json){
    return Address(
      zipCode: json["zipCode"],
      long: json["long"],
      lat: json["lat"],
      city: json["city"],
      state: json["state"],
      district: json["district"],
      complement: json["complement"],
      number: json["number"],
      street: json["street"]
    );
  }
}
