import 'package:flutter/material.dart';
import 'package:movie_app/src/models/actores_model.dart';
import 'package:movie_app/src/models/pelicula_model.dart';
import 'package:movie_app/src/providers/peliculas_provider.dart';

class PeliculaDetallePage extends StatelessWidget {
  const PeliculaDetallePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _creareAppBar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 10,
                ),
                _posterTitulo(context, pelicula),
                _descripcion(pelicula),
                _crearCasting(pelicula),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _creareAppBar(Pelicula pelicula) {
    print(pelicula.backgroundImage);

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.backgroundImage),
          placeholder: AssetImage('assets/images/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: NetworkImage(pelicula.posterImg),
              height: 150.0,
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  _crearCasting(Pelicula pelicula) {
    final PeliculasProvider peliculasProvider = new PeliculasProvider();
    return FutureBuilder(
      future: peliculasProvider.obtenerActores(
        pelicula.id.toString(),
      ),
      builder: (BuildContext context, AsyncSnapshot<List> snapShot) {
        if (snapShot.hasData) {
          return _crearActores(snapShot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearActores(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemCount: actores.length,
        itemBuilder: (BuildContext context, int index) {
          return _actorTarjeta(actores[index]);
        },
      ),
    );
  }

  Widget _actorTarjeta(Actor actor) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              image: NetworkImage(actor.profileImg),
              placeholder: AssetImage('assets/images/no-image.jpg'),
              height: 150,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
