
import 'dart:convert';

import 'package:http/http.dart' as http;

String _key = "JnyxyjmCCTxT8TmYwA1gZRsASEVJDeHZ";

class GiphyService {
  Future<Map> getGifs(String _search, int _offset) async{
    http.Response response;
    if(_search == null || _search.isEmpty){
      response = await http.get(Uri.parse("https://api.giphy.com/v1/gifs/trending?api_key=JnyxyjmCCTxT8TmYwA1gZRsASEVJDeHZ&limit=25&offset=0&rating=g&bundle=messaging_non_clips"));
    }else{
      response = await http.get(Uri.parse("https://api.giphy.com/v1/gifs/search?api_key=$_key&q=$_search&limit=25&offset=$_offset&rating=g&lang=en&bundle=messaging_non_clips"));
    }
    print(response);
    return json.decode(response.body);
  }
}
