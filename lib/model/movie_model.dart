import 'dart:convert';

import 'package:movie/services/constant.dart';

class Movie {
  int movieId;
  String name;
  String description;
  String bannerUrl;
  String posterUrl;
  DateTime launch;
  double rating;
  List<int> genreIds;
  bool addWatch;
  Movie({
    required this.movieId,
    required this.name,
    required this.description,
    required this.bannerUrl,
    required this.posterUrl,
    required this.launch,
    required this.rating,
    required this.genreIds,
    this.addWatch = false,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      name: map['title'] ?? "",
      description: map['overview'] ?? '',
      bannerUrl: map['backdrop_path'] != null
          ? Constants.imagebaseurl + map['backdrop_path']
          : "",
      posterUrl: map['poster_path'] != null
          ? Constants.imagebaseurl + map['poster_path']
          : "",
      launch: DateTime.parse(map['release_date']),
      rating: map['vote_average'].toDouble() ?? 0.0,
      movieId: map['id'] as int,
      genreIds: List<int>.from(map['genre_ids']),
    );
  }

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}
