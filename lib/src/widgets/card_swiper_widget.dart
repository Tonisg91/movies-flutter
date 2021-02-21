import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> cardList;

  CardSwiper({@required this.cardList});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          cardList[index].uniqueId = '${cardList[index].id}-swiper';
          return _card(context, cardList[index]);
        },
        itemCount: cardList.length,
        layout: SwiperLayout.STACK,
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie){
    final movieContainer = Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(
                  movie.getPosterImg()
                ),
                fit: BoxFit.cover,
              )
            ),
          );
    
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
      child: movieContainer
    );
  }
}
