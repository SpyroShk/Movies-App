import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/movie_model.dart';
import 'movieservice_provider.dart';

final moviesProvider = FutureProvider.family<Future<List<Movie>?>?, String>(
  (ref, tab) => ref.read(moviesServiceProvider).loadMovies(tab),
);