import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/movie_service.dart';

final moviesServiceProvider = Provider(
  (ref) => MovieService(),
);