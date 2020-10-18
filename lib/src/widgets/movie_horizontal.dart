import 'package:flutter/material.dart';
import 'package:movie_app/src/models/pelicula_model.dart';

import 'movie_card_widget.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  final PageController _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  MovieHorizontal(
      {Key key, @required this.peliculas, @required this.siguientePagina})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      final posicionActual = _pageController.position.pixels;
      final longitudLista = _pageController.position.maxScrollExtent;
      final bool cargarMasPeliculas = posicionActual > longitudLista - 200;

      if (cargarMasPeliculas) {
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.4,
      child: PageView.builder(
        controller: _pageController,
        pageSnapping: false,
        itemCount: peliculas.length,
        itemBuilder: (context, index) => MovieCard(pelicula: peliculas[index]),
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
