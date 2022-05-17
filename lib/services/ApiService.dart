import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {
  late String token;

  ApiService(String token) {
    this.token = token;
  }

  final String baseUrl = '';

  /* ##### Model Track #### */
  /* Future<TrackResponse> fetchTracks() async {
    TrackResponse _owner;
    http.Response response = await http.get(
      Uri.parse(baseUrl + 'medias'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );

    var owner = jsonDecode(response.body);

    _owner = TrackResponse.fromJson(owner);
    return _owner;
  } */
}
