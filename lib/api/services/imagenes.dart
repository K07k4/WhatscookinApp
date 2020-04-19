import 'package:http/http.dart' as http;
import 'package:whatscookin/api/api.dart' as api;

String path = api.baseUrl + "/imagen";

Future<String> getImagen(String tipo, int id) async {
  final response = await http.get(path + "/get?id="+id.toString()+"&tipo=" + tipo);

  if(response.statusCode == 200) {
    return response.body;

  } else {
    throw Exception('Failed to load album');
  }
}