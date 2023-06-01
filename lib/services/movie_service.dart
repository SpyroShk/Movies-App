import 'package:movie/model/movie_model.dart';
import 'package:movie/services/constant.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../model/cast_model.dart';
import '../model/review_model.dart';
import '../model/runtime_model.dart';

class MovieService {
  static const apikey = Constants.apikey;
  static const readaccesstoken = Constants.readaccesstoken;

  static TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(apikey, readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Future<List<Movie>?>? loadMovies(String tab) async {
    List<Movie> movies = [];
    List apiDatas = [];
    switch (tab) {
      case "Now Playing":
        apiDatas =
            (await tmdbWithCustomLogs.v3.movies.getNowPlaying())["results"];
        break;
      case "Upcoming":
        apiDatas =
            (await tmdbWithCustomLogs.v3.movies.getUpcoming())["results"];
        break;
      case "Top Rated":
        apiDatas =
            (await tmdbWithCustomLogs.v3.movies.getTopRated())["results"];
        break;
      case "Popular":
        apiDatas = (await tmdbWithCustomLogs.v3.movies.getPopular())["results"];
    }
    for (final apiData in apiDatas) {
      Movie movie = Movie.fromMap(apiData);
      movies.add(movie);
    }
    return movies;
  }

  Future<List<Movie>> loadTrending() async {
    List<Movie> movies = [];
    List apiDatas = [];
    apiDatas = (await tmdbWithCustomLogs.v3.trending.getTrending())["results"];
    for (final apiData in apiDatas) {
      if (apiData["media_type"] == "movie") {
        Movie movie = Movie.fromMap(apiData);
        movies.add(movie);
      }
    }

    return movies;
  }

  Future<List<Review>?> loadReviews(int movieId) async {
    List<Review> reviews = [];
    List apiDatas = [];
    apiDatas =
        (await tmdbWithCustomLogs.v3.movies.getReviews(movieId))["results"];
    for (final apiData in apiDatas) {
      Review review = Review.fromMap(apiData);
      reviews.add(review);
      // print(review);
    }
    return reviews;
  }

  Future<List<Cast>?> loadCasts(int movieId) async {
    List<Cast> casts = [];
    List apiDatas = [];
    apiDatas = (await tmdbWithCustomLogs.v3.movies.getCredits(movieId))["cast"];
    for (final apiData in apiDatas) {
      Cast cast = Cast.fromMap(apiData);
      casts.add(cast);
    }
    return casts;
  }

  Future<List<Movie>> loadSearchedMovies(String query) async {
    List<Movie> movies = [];
    if (query.isNotEmpty) {
      List apiDatas = [];
      apiDatas =
          (await tmdbWithCustomLogs.v3.search.queryMovies(query))["results"];
      for (final apiData in apiDatas) {
        Movie movie = Movie.fromMap(apiData);
        movies.add(movie);
      }
    }
    return movies;
  }

  Future<List<Runtime>?> loadRuntime(int movieId) async {
    List<Runtime> runtimes = [];
    List apiDatas = [];
    apiDatas = [await tmdbWithCustomLogs.v3.movies.getDetails(movieId)];
    for (final apiData in apiDatas) {
      Runtime runtime = Runtime.fromMap(apiData);
      runtimes.add(runtime);
    }
    return runtimes;
  }
}
