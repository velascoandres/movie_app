import 'package:flutter/material.dart';
import 'package:movie_app/src/models/pelicula_model.dart';

class PeliculaDetallePage extends StatelessWidget {
  const PeliculaDetallePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('${pelicula.title}'),
      ),
    );
  }
}
