import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifer/search_notifier.dart';
import 'movieservice_provider.dart';

final searchProvider = ChangeNotifierProvider.autoDispose<SearchNotifier>(
  (ref) => SearchNotifier(ref.read(moviesServiceProvider)),
);
