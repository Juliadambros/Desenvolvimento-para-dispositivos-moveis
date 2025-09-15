import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class InvertextoService {
  final String _token = "21562|EOeIbFFUD9m517hLv6YOFGkp3fNcOmgS";

  Future<Map<String, dynamic>> convertePorExtenso(String? valor, String currency) async{
    try{
      final uri = Uri.parse("https://api.invertexto.com/v1/number-to-words?token=${_token}&number=${valor}&language=pt&currency=${currency}");
      final response = await http.get(uri);
      if(response.statusCode == 200){
        return json.decode(response.body);
      }else{
        throw Exception('Erro ${response.statusCode}: ${response.body}');
      }
    }on SocketException{
      throw Exception('Erro de conexão com a internet.');
    }catch(e){
      rethrow;
    }
  }

  Future<Map<String, dynamic>> buscaCEP(String? valor) async{
    try{
      final uri = Uri.parse("https://api.invertexto.com/v1/cep/${valor}?token=${_token}");
      final response = await http.get(uri);
      if(response.statusCode == 200){
        return json.decode(response.body);
      }else{
        throw Exception('Erro ${response.statusCode}: ${response.body}');
      }
    }on SocketException{
      throw Exception('Erro de conexão com a internet.');
    }catch(e){
      rethrow;
    }
  }

  Future<Map<String, dynamic>> buscaCNPJ(String? valor) async{
    try{
      final uri = Uri.parse("https://api.invertexto.com/v1/cnpj/${valor}?token=${_token}");
      final response = await http.get(uri);
      if(response.statusCode == 200){
        return json.decode(response.body);
      }else{
        throw Exception('Erro ${response.statusCode}: ${response.body}');
      }
    }on SocketException{
      throw Exception('Erro de conexão com a internet.');
    }catch(e){
      rethrow;
    }
  }
}