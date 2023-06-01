import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/provider/watchlist_provider.dart';
import 'package:movie/widgets/custom_appbar.dart';
import 'package:movie/widgets/listview_ui.dart';

class WatchlistPage extends ConsumerStatefulWidget {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  ConsumerState<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends ConsumerState<WatchlistPage> {
  @override
  Widget build(BuildContext context) {
    final newMovies = ref.watch(watchlistProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF242A32),
      appBar: const CustomAppbar(
        title: 'Watch list',
        height: 80,
      ),
      body: newMovies.movies.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/magicbox.png",
                    height: 76,
                    width: 76,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'There Is No Movie Yet!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    width: 240,
                    child: Text(
                      'Find your movie by Type title, categories, years, etc.',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF92929D),
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: newMovies.movies.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                separatorBuilder: (context, index) => Container(
                  height: 8,
                ),
                itemBuilder: (context, index) {
                  return ListviewUi(
                    movie: newMovies.movies[index],
                  );
                },
              ),
            ),
    );
  }
}
