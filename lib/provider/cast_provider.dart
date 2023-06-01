import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/cast_model.dart';
import 'movieservice_provider.dart';

final castProvider = FutureProvider.family<Future<List<Cast>?>?, int>(
  (ref, movieId) => ref.read(moviesServiceProvider).loadCasts(movieId),
);