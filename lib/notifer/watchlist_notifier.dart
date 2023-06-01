import 'package:flutter/cupertino.dart';

import '../model/movie_model.dart';

class WatchlistNotifier extends ChangeNotifier {
  List<Movie> movies = [];

  void addMovies(Movie data) {
    movies.add(data);
    notifyListeners();
  }

  void removeMovies(Movie data) {
    movies.remove(data);
    notifyListeners();
  }
}
