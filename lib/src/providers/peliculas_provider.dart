import 'dart:convert';

import 'package:http/http.dart' as httpClient;

import 'package:movie_app/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = 'f9cffb86fafb0e6fe2a130530209e1ee';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';

  Future<List<Pelicula>> get enCines async {
    final parametros = {
      'api_key': _apiKey,
      'languaje': _languaje,
    };
    final url = Uri.https(_url, '/3/movie/now_playing', parametros);
    final respuesta = await httpClient.get(url);
    final decodeData = json.decode(respuesta.body);
    final peliculas = new Peliculas.fromJsonList(decodeData['results']);
    return peliculas.items;
  }
}
