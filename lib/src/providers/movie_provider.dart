import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {
  String _apikey = 'eb5ae567095902d6e3ce7ec8a81e0e1d';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Movie>> getPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apikey,
      'language': _language
    });
    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }
}