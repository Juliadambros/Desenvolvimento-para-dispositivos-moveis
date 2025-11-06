import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class BuscaFilmeService {
  final String _apiKey = ""; 
  Future<Map<String, dynamic>> buscarFilme(String titulo) async {
    try {
      final uri = Uri.parse("https://www.omdbapi.com/?t=$titulo&apikey=$_apiKey");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final dados = json.decode(response.body);
        if (dados["Response"] == "True") {
          return dados;
        } else {
          throw Exception("Filme não encontrado.");
        }
      } else {
        throw Exception('Erro ${response.statusCode}: ${response.body}');
      }
    } on SocketException {
      throw Exception('Erro de conexão com a internet.');
    } catch (e) {
      rethrow;
    }
  }
}
