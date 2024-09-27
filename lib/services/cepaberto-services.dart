
import 'dart:io';

import 'package:dio/dio.dart';

const token = "67fcd8a6ae284c831f32fd1e08fad25d";
class CepAbertoServices{

 Future<void> getAddressFromCep(String cep)async{
   final cleanCep = cep.replaceAll(".", "").replaceAll("-", "");

   final String endPoint ="https://www.cepaberto.com/api/v3/cep?cep=$cleanCep";

   final Dio dio = Dio();
   dio.options.headers[HttpHeaders.authorizationHeader] = "Token token=$token";
   try{
     final response = await dio.get<Map>(endPoint);
     if(response.data == null || response.data!.isEmpty){
       return Future.error("CEP Inválido");
     }
   }on DioException catch(e){
     return Future.error("Erro ao buscar CEP");
   }

 }
}