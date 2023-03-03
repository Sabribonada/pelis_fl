import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '23d3fb694ee44d045a3753ed15d26a8f';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  MoviesProvider() {
    // print('Inicializado xd');
    getNowPlaying();
  }

  // getOnDisplayMovies en el curso
  getNowPlaying() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    final response = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(response.body);

    print(decodedData['dates']);
  }
}
