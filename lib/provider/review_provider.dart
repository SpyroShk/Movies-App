import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/review_model.dart';
import 'movieservice_provider.dart';

final reviewProvider = FutureProvider.family<Future<List<Review>?>?, int>(
  (ref, movieId) => ref.read(moviesServiceProvider).loadReviews(movieId),
);