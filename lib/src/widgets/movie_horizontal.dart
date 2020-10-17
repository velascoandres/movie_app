import 'package:flutter/material.dart';
import 'package:movie_app/src/models/pelicula_model.dart';

import 'movie_card_widget.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;

  const MovieHorizontal({Key key, @required this.peliculas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.3,
      child: PageView(
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        children: _tarjetas(),
      ),
    );
  }

  List<Widget> _tarjetas() {
    return peliculas.map(
      (Pelicula pelicula) {
        return MovieCard(
          pelicula: pelicula,
        );
      },
    ).toList();
  }
}
