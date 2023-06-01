import 'package:flutter/cupertino.dart';

import '../model/movie_model.dart';
import '../services/movie_service.dart';

class SearchNotifier extends ChangeNotifier {
  SearchNotifier(this._service);
  List<Movie>? _searchData;
  List<Movie>? get searchDetails => _searchData;
  final MovieService _service;
  void loadSearchDetail(query) async {
    _searchData = await _service.loadSearchedMovies(query);
    notifyListeners();
  }
}
