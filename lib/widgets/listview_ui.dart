import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:movie/model/movie_model.dart';
import 'package:movie/widgets/runtime.dart';
import '../provider/runtime_provider.dart';
import '../screens/details_page.dart';
import '../utilities/genre_utils.dart';

class ListviewUi extends ConsumerWidget {
  final Movie movie;
  const ListviewUi({
    required this.movie,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final runtimeMovies = ref.watch(runtimeProvider(movie.movieId));
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailsPage(movie: movie),
              ),
            );
          },
          child: SizedBox(
            height: 130,
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: movie.posterUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 95.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/details/Star.svg'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            movie.rating.toString(),
                            style: const TextStyle(
                              color: Color(0xFFFF8700),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/details/Ticket.svg'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            GenreUtils.getGenres(movie),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF92929D),
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          SvgPicture.asset(
                              'assets/icons/details/CalendarBlank.svg'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            DateFormat.y().format(movie.launch),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF92929D),
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/details/Clock.svg'),
                          const SizedBox(
                            width: 5,
                          ),
                          runtimeMovies.when(
                            data: (runtimes) => Runtimes(
                              future: runtimes,
                              movies: movie,
                            ),
                            error: (error, stackTrace) =>
                                const Icon(Icons.error),
                            loading: () => const Center(
                                child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
