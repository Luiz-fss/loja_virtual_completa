
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loja_virtual_completa/models/cepaberto-address.dart';

const token = "67fcd8a6ae284c831f32fd1e08fad25d";
class CepAbertoServices{

 Future<CepAbertoAddress?> getAddressFromCep(String cep)async{
   final cleanCep = cep.replaceAll(".", "").replaceAll("-", "");

   final String endPoint ="https://www.cepaberto.com/api/v3/cep?cep=$cleanCep";

   final Dio dio = Dio();
   dio.options.headers[HttpHeaders.authorizationHeader] = "Token token=$token";
   try{
     final response = await dio.get<Map<String,dynamic>>(endPoint);
     if(response.data == null || response.data!.isEmpty){
       return Future.error("CEP Inválido");
     }
     return CepAbertoAddress().fromJson(response.data!);

   }on DioException catch(e){
     return Future.error("Erro ao buscar CEP");
   }

 }
}