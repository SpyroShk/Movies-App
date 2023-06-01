import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/runtime_model.dart';
import 'movieservice_provider.dart';

final runtimeProvider = FutureProvider.family<Future<List<Runtime>?>?, int>(
  (ref, movieId) => ref.read(moviesServiceProvider).loadRuntime(movieId),
);
