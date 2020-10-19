import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as httpClient;
import 'package:movie_app/src/models/actores_model.dart';

import 'package:movie_app/src/models/pelicula_model.dart';

class PeliculasProvider<T> {
  String _apiKey = 'f9cffb86fafb0e6fe2a130530209e1ee';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';

  int _popularesPage = 0;

  bool _cargando = false;

  List<Pelicula> _populares = new List();

  // Sin el broadcast se vuelve single.
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> procesarRespuesta(Uri url) async {
    final respuesta = await httpClient.get(url);
    final decodeData = json.decode(respuesta.body);
    final peliculas = new Peliculas.fromJsonList(decodeData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> get enCines async {
    final parametros = {
      'api_key': _apiKey,
      'languaje': _languaje,
    };
    final url = Uri.https(_url, '/3/movie/now_playing', parametros);
    return this.procesarRespuesta(url);
  }

  Future<List<Pelicula>> get populares async {
    if (_cargando) {
      return [];
    }

    _cargando = true;

    _popularesPage++;

    print('Cargando siguientes');

    final parametros = {
      'api_key': _apiKey,
      'languaje': _languaje,
      'page': _popularesPage.toString(),
    };
    final url = Uri.https(_url, '/3/movie/popular', parametros);
    final List<Pelicula> respuesta = await this.procesarRespuesta(url);

    _populares.addAll(respuesta);
    popularesSink(_populares);
    _cargando = false;

    return respuesta;
  }

  Future<List<Actor>> obtenerActores(String idPelicula) async {
    final parametros = {
      'api_key': _apiKey,
      'languaje': _languaje,
    };
    final url = Uri.https(_url, '/3/movie/$idPelicula/credits', parametros);
    final respuesta = await httpClient.get(url);
    final decodeData = json.decode(respuesta.body);
    final cast = new Cast.fromJsonList(decodeData['cast']);
    return cast.actores;
  }
}
