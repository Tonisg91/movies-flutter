import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movie_provider.dart';

class DataSearch extends SearchDelegate {

  String selection = '';
  final moviesProvider = new MoviesProvider();

  final movies = [
    'Aquaman',
    'Batman',
    'Batman Begins',
    'Bomberman',
    'Calendarman',
    'Captain America',
    'Captain America: Winter Soldier',
    'Shazam',
    'Spiderman',
    'Spiderman: Homecoming',
    'Superman',
    'Wonder woman',
  ];

  final recentMovies = ['Spiderman', 'Captain America'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Appbar action
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon on left side og the appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Builder of results to show
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(selection)
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions that appears when user types
    if (query.isEmpty) return Container();
    return FutureBuilder(
      future: moviesProvider.getMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

        final movies = snapshot.data;
        List displayMovies = movies.map((m) => ListTile(
          leading: FadeInImage(
            image: NetworkImage(m.getPosterImg()),
            placeholder: AssetImage('assets/img/no-image.jpg'),
            width: 50.0,
            fit: BoxFit.contain,
          ),
          title: Text(m.title),
          subtitle: Text(m.originalTitle),
          onTap: () {
            close(context, null);
            m.uniqueId = '';
            Navigator.pushNamed(context, 'detail', arguments: m);
          },
        ))
        .toList();


        return ListView(
          children: displayMovies,
        );
      },
    );
  }
}