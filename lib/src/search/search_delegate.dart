import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {

  String selection = '';

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

    Function _filterMovies = (String m) => m.toLowerCase()
                                            .contains(query.toLowerCase());

    final suggestionList = (query.isEmpty) 
                            ? recentMovies
                            : movies.where(_filterMovies).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(suggestionList[i]),
          onTap: (){
            selection = suggestionList[i];
            showResults(context);
          }
        );
      },
    );
  }

}