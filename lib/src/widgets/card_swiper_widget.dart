import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class CardSwipper extends StatelessWidget {
  final List<dynamic> peliculas;

  CardSwipper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10),
      child: new Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].idUnico = '${peliculas[index].id}-poster';
          final tarjeta = Hero(
            tag: peliculas[index].idUnico,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(peliculas[index].posterImg),
                placeholder: Image(
                  width: _screenSize.width * 0.7,
                  height: _screenSize.height * 0.5,
                  image: Svg('assets/images/pacman.svg'),
                ).image,
                fit: BoxFit.cover,
              ),
            ),
          );
          return GestureDetector(
            child: tarjeta,
            onTap: () {
              Navigator.pushNamed(context, 'detalle',
                  arguments: peliculas[index]);
            },
          );
        },
        itemCount: peliculas.length,
      ),
    );
  }
}
