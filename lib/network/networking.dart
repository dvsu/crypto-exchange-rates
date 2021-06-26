import 'package:http/http.dart' as http;

class Networking {
  Future<dynamic> networkResponse({required Uri url}) async {
    // try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
    // } catch (e) {
    //   return throw ("Not connected to internet");
    // }
  }
}
