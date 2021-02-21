import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/src/models/actors_model.dart';
import 'dart:async';

import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {

  String _apikey = 'eb5ae567095902d6e3ce7ec8a81e0e1d';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  bool _loading = false;
  
  int _popularPage = 0;

  List<Movie> _popular = new List();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disposeStreams() {
    _popularStreamController?.close();
  }

  Future<List<Movie>> _processResponse(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }


  // Get Playing Movies
  Future<List<Movie>> getPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apikey,
      'language': _language
    });

    return _processResponse(url);
  }

  // Get Popular Movies
  Future<List<Movie>> getPopular() async {
    if (_loading) return [];

    _loading = true;
    _popularPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apikey,
      'language': _language,
      'page': _popularPage.toString()
    });

    final response = await _processResponse(url);

    _popular.addAll(response);
    popularSink(_popular);

    _loading = false;
    return response;
  }

  Future<List<Actor>> getCast(String movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key' : _apikey,
      'language': _language
    });

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actorList;
  }
}