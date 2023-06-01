import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/widgets/search_box.dart';
import '../provider/movies_provider.dart';
import '../provider/trending_provider.dart';
import '../widgets/movie_tile.dart';
import '../widgets/trending.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // late TextEditingController _searchTextController;
  // late ScrollController _scrollController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    // _searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    // _searchTextController.dispose();
    // _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final searchedMovies =
    //     ref.watch(searchProvider(_searchTextController.text));
    // final searchTextController = TextEditingController();
    return Scaffold(
        backgroundColor: const Color(0xFF242A32),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Container(
            padding: const EdgeInsets.only(left: 10),
            child: const Text(
              'What do you want to watch?',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: SearchBox(
                isHomeScreen: true,
                onSubmit: () {},
                textEnabled: false,
              ),
            ),
          ),
        ),
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          // controller: _scrollController,
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 230,
                  child: ref.watch(trendingProvider("Trending")).when(
                        data: (movies) => ListView(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [Trending(future: movies)],
                        ),
                        error: (error, stackTrace) => const Icon(Icons.error),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                  //
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(top: 50, left: 18),
                  height: 90,
                  child: TabBar(
                    indicatorColor: const Color(0xFF3A3F47),
                    indicatorWeight: 4,
                    indicatorPadding:
                        const EdgeInsets.symmetric(horizontal: 10),
                    controller: _tabController,
                    isScrollable: true,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                    tabs: const [
                      Tab(text: 'Now Playing'),
                      Tab(text: 'Upcoming'),
                      Tab(text: 'Top rated'),
                      Tab(text: 'Popular'),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: SizedBox(
            child: TabBarView(
              controller: _tabController,
              children: [
                ref.watch(moviesProvider("Now Playing")).when(
                      data: (movies) => MovieTile(
                        future: movies,
                      ),
                      error: (error, stackTrace) => const Icon(Icons.error),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                ref.watch(moviesProvider("Upcoming")).when(
                      data: (movies) => MovieTile(
                        future: movies,
                      ),
                      error: (error, stackTrace) => const Icon(Icons.error),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                ref.watch(moviesProvider("Top Rated")).when(
                      data: (movies) => MovieTile(
                        future: movies,
                      ),
                      error: (error, stackTrace) => const Icon(Icons.error),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                ref.watch(moviesProvider("Popular")).when(
                      data: (movies) => MovieTile(
                        future: movies,
                      ),
                      error: (error, stackTrace) => const Icon(Icons.error),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                    ),
              ],
            ),
          ),
        ),);
  }
}
