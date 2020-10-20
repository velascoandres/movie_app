import 'package:flutter/material.dart';
import 'package:movie_app/src/models/pelicula_model.dart';
import 'package:movie_app/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  final PeliculasProvider peliculasProvider = new PeliculasProvider();

  List<Pelicula> peliculasEncontradas = [];

  String seleccion;

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones del appBar (limpiar y cancelar)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return _listaPeliculasEncontradas(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Las sugerencias que aparecen cuando la persona escribe

    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> respuesta) {
        if (respuesta.hasData) {
          peliculasEncontradas = respuesta.data;
          return _listaPeliculasEncontradas(context);
        } else {
          peliculasEncontradas = [];
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _listaPeliculasEncontradas(BuildContext context) {
    return ListView(
      children: peliculasEncontradas
          .map(
            (pelicula) => itemPeliculaSugerida(context, pelicula),
          )
          .toList(),
    );
  }

  Widget itemPeliculaSugerida(BuildContext context, Pelicula pelicula) {
    return ListTile(
      leading: FadeInImage(
        image: NetworkImage(pelicula.posterImg),
        placeholder: AssetImage('assets/images/no-image.jpg'),
        width: 50.0,
        fit: BoxFit.contain,
      ),
      title: Text(pelicula.title),
      subtitle: Text(pelicula.originalTitle),
      onTap: () {
        seleccion = pelicula.id.toString();
        // showResults(context);
        // comento el close depende si quieres regresar a la busqueda
        // close(context, null);
        pelicula.idUnico = '';
        Navigator.pushNamed(
          context,
          'detalle',
          arguments: pelicula,
        );
      },
    );
  }
}
