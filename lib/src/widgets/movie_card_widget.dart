import 'package:flutter/material.dart';
import 'package:movie_app/src/models/pelicula_model.dart';

class MovieCard extends StatelessWidget {
  final Pelicula pelicula;
  const MovieCard({Key key, @required this.pelicula}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              image: NetworkImage(pelicula.posterImg),
              placeholder: AssetImage('assets/images/loading.gif'),
              fit: BoxFit.cover,
              height: 160.0,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 5.0,),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
