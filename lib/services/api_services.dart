import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  login(String username, String password) async {
    var request = http.Request('POST', Uri.parse('https://dummyjson.com/auth/login'));
    request.body = json.encode({"username": "emilys", "password": "emilyspass"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    try {
      var data = await response.stream.bytesToString();
      return jsonDecode(data);
    } catch (e) {}
  }

  getData() async {
    var request = http.Request('GET', Uri.parse('https://jsonplaceholder.typicode.com/comments'));

    http.StreamedResponse response = await request.send();
    try {
      var data = await response.stream.bytesToString();
      return jsonDecode(data);
    } catch (e) {}
  }
}
