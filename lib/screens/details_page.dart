import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:movie/provider/cast_provider.dart';
import 'package:movie/provider/runtime_provider.dart';
import 'package:movie/provider/watchlist_provider.dart';
import 'package:movie/widgets/custom_appbar.dart';
import 'package:movie/widgets/load_casts.dart';
import 'package:movie/widgets/load_reviews.dart';
import 'package:movie/widgets/runtime.dart';
import '../model/movie_model.dart';
import '../provider/review_provider.dart';
import '../utilities/genre_utils.dart';

class DetailsPage extends ConsumerStatefulWidget {
  final Movie movie;
  const DetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  ConsumerState<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget buildBlur({
    required Widget child,
    required BorderRadius borderRadius,
    double sigmaX = 10,
    double sigmaY = 10,
  }) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: sigmaX,
          sigmaY: sigmaY,
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reviewMovies = ref.watch(reviewProvider(widget.movie.movieId));
    final castMovies = ref.watch(castProvider(widget.movie.movieId));
    final newMovies = ref.watch(watchlistProvider);
    final runtimeMovies = ref.watch(runtimeProvider(widget.movie.movieId));
    final removedMovies = ref.read(watchlistProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF242A32),
      appBar: CustomAppbar(
        height: 80,
        title: 'Detail',
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/appbar/arrow-left.svg'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: widget.movie.addWatch == false
                ? () {
                    newMovies.addMovies(widget.movie);
                    setState(() {
                      widget.movie.addWatch = true;
                    });
                  }
                : () {
                    removedMovies.removeMovies(widget.movie);
                    setState(() {
                      widget.movie.addWatch = false;
                    });
                  },
            icon: widget.movie.addWatch == false
                ? const Icon(
                    Icons.bookmark_outline,
                    size: 30.0,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.bookmark,
                    size: 30.0,
                    color: Colors.white,
                  ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    height: 280,
                    child: Stack(
                      children: [
                        Positioned(
                          child: SizedBox(
                            height: 210,
                            width: MediaQuery.of(context).size.width,
                            child: CachedNetworkImage(
                              imageUrl: widget.movie.bannerUrl.toString(),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 25,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 120,
                                width: 95,
                                child: CachedNetworkImage(
                                  imageUrl: widget.movie.posterUrl,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 95.0,
                                    height: 120.0,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16)),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              SizedBox(
                                width: 240,
                                child: Text(
                                  widget.movie.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 85,
                          right: 10,
                          child: buildBlur(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/icons/details/Star.svg'),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.movie.rating.toString(),
                                    style: const TextStyle(
                                      color: Color(0xFFFF8700),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                            'assets/icons/details/CalendarBlank.svg'),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat.y().format(widget.movie.launch),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF92929D),
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: VerticalDivider(
                        width: 16,
                        thickness: 1,
                        color: Color(0xFF92929D),
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/details/Clock.svg'),
                        const SizedBox(
                          width: 5,
                        ),
                        runtimeMovies.when(
                          data: (runtimes) => Runtimes(
                            future: runtimes,
                            movies: widget.movie,
                          ),
                          error: (error, stackTrace) => const Icon(Icons.error),
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: VerticalDivider(
                        width: 16,
                        thickness: 1,
                        color: Color(0xFF92929D),
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/details/Ticket.svg'),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          GenreUtils.getGenres(widget.movie),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF92929D),
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: TabBar(
                padding: const EdgeInsets.only(left: 20, top: 30),
                indicatorColor: const Color(0xFF3A3F47),
                indicatorWeight: 4,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
                controller: _tabController,
                isScrollable: true,
                labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                tabs: const [
                  Tab(text: 'About Movie'),
                  Tab(text: 'Reviews'),
                  Tab(text: 'Cast'),
                ],
              ),
            ),
          ];
        },
        body: SizedBox(
          child: TabBarView(
            controller: _tabController,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  widget.movie.description.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              reviewMovies.when(
                data: (reviews) => Center(child: LoadReviews(future: reviews)),
                error: (error, stackTrace) => const Icon(Icons.error),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
              castMovies.when(
                data: (casts) => Center(child: LoadCasts(future: casts)),
                error: (error, stackTrace) => const Icon(Icons.error),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
