import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/address.dart';
import 'package:loja_virtual_completa/helpers/extensions.dart';


enum StoreStatus{ closed,open,closing}
class Store{

  String? name;
  String? phone;
  String? image;
  Address? address;
  Map<String,dynamic>? opening;
  StoreStatus? status;




  Store.fromDocument(DocumentSnapshot doc){
    name = doc["name"];
    phone = doc["phone"];
    image = doc["image"];
    address = Address.fromMap(doc["address"] as Map<String,dynamic>);
    opening = (doc["opening"] as Map<String,dynamic>).map((key,value){
      final timeString = value as String;
      if(timeString != null && timeString.isNotEmpty){

        final splitted = timeString.split(RegExp(r"[:-]"));
        return MapEntry(key, {
          "from":TimeOfDay(hour: int.parse(splitted[0]),minute: int.parse(splitted[1])),
          "to":TimeOfDay(hour: int.parse(splitted[2]),minute: int.parse(splitted[3]))
        });
      }else{
        return MapEntry(key, null);
      }

    });
    updateStatus();
  }

  String get addressText => "${address?.street}, ${address?.number}, ${address?.complement} - "
      "${address?.district}, ${address?.city}/${address?.state}";

  String get openingText{
    return
        "Seg-Sex: ${formattedPeriod(opening!["monfri"])}\n"
            "Sab: ${formattedPeriod(opening!["saturday"])}\n"
            "Dom: ${formattedPeriod(opening!["sunday"])}\n";
  }

  String formattedPeriod(Map<String,TimeOfDay>? period){
    if(period == null){
      return "Fechado";
    }
    return "${period["from"]?.formatted()} - ${period["to"]?.formatted()}";
  }

  void updateStatus(){
    final weekDay = DateTime.now().weekday;

    Map<String,TimeOfDay>? period;
    if(weekDay >=1 && weekDay<=5){
      period = opening?["monfri"];
    }else if(weekDay==6){
      period = opening?["saturday"];
    }else{
      period = opening?["sunday"];
    }

    final now = TimeOfDay.now();

    if(period == null){
      status = StoreStatus.closed;
    }else if(period["from"]!.toMinutes() < now.toMinutes()
        && period["to"]!.toMinutes() -15 > now.toMinutes()){
      status = StoreStatus.open;
    }else if(period["from"]!.toMinutes() < now.toMinutes()
        && period["to"]!.toMinutes() > now.toMinutes()){
      status = StoreStatus.closing;
    }else{
      status = StoreStatus.closed;
    }
  }


  String get statusText{
    switch(status) {
      case StoreStatus.closed:
       return "Fechado";

      case StoreStatus.open:
        return "Aberto";

      case StoreStatus.closing:
        return "Fechando";
      case null:
        return  "";
    }
  }

  String? get cleanPhone => phone?.replaceAll(RegExp("[^\d]"), "");
}