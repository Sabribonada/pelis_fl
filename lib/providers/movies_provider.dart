import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pelis_fl/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '23d3fb694ee44d045a3753ed15d26a8f';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';
  int _popularPage = 0;

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> movieCast = {};

  MoviesProvider() {
    getNowPlaying();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });
    final response = await http.get(url);
    return response.body;
  }

  // getOnDisplayMovies en el curso
  getNowPlaying() async {
    final jsonData = await _getJsonData('3/movie/now_playing');

    final nowPlayingResp = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResp.results;

    notifyListeners();
  }
  // var url = Uri.https(_baseUrl, , {

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);

    final popularResp = PopularResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularResp.results];
    notifyListeners();
  }

  Future<List<Cast>> getMoviesCast(int movieId) async {
    if (movieCast.containsKey(movieId)) return movieCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    movieCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    var url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }
}
