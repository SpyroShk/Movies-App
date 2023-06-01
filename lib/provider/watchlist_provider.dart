import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifer/watchlist_notifier.dart';

final watchlistProvider = ChangeNotifierProvider(
  (ref) => WatchlistNotifier(),
);
