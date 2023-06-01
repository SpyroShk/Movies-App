import '../model/movie_model.dart';

class GenreUtils {
  static String getGenres(Movie movie) {
    List<String> genres = [];

    for (var id in movie.genreIds) {
      for (var map in [
        {28: 'Action'},
        {12: 'Adventure'},
        {16: 'Animation'},
        {35: 'Comedy'},
        {80: 'Crime'},
        {99: 'Documentary'},
        {18: 'Drama'},
        {10751: 'Family'},
        {14: 'Fantasy'},
        {36: 'History'},
        {27: 'Horror'},
        {10402: 'Music'},
        {9648: 'Mystery'},
        {10749: 'Romance'},
        {878: 'Science Fiction'},
        {10770: 'TV Movie'},
        {53: 'Thriller'},
        {10752: 'War'},
        {37: 'Western'}
      ]) {
        map.keys.first == id ? genres.add(map.values.first) : null;
      }
    }
    return genres.isEmpty ? 'N/A' : genres.first;
  }
}
