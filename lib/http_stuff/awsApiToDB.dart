import 'dart:convert';

import 'package:http/http.dart' as http;

class AWSApiToDB {

  final String playlistUrl;

  AWSApiToDB({
    required this.playlistUrl
  });

  Future<Map<String, dynamic>> getDataFromAWSApi() async {
    String linkToApi = 'http://13.127.186.252:8080/pl?l=';
    String link = linkToApi+this.playlistUrl;
    print('link = ${link}');
    var url = Uri.parse(link);
    var response = await http.get(url);
    print('Response: ${jsonDecode(response.body)}');
    return jsonDecode(response.body);
  }
}