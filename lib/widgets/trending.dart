import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/screens/details_page.dart';

import '../model/movie_model.dart';

class Trending extends StatelessWidget {
  final Future<List<Movie>?>? future;
  const Trending({
    Key? key,
    // required this.movies,
    this.future,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 225,
      child: FutureBuilder<List<Movie>?>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                movie: snapshot.data![index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 150,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data![index].posterUrl,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        )
                        // : Container(),
                        // Container(
                        //   margin: EdgeInsets.symmetric(horizontal: 15),
                        //   width: 150,
                        //   decoration: BoxDecoration(
                        //     borderRadius: const BorderRadius.all(Radius.circular(16)),

                        //     image: DecorationImage(
                        //       image:
                        //       NetworkImage('https://image.tmdb.org/t/p/w500' +
                        //           trending[index]['poster_path']),
                        //     ),
                        //   ),
                        // ),
                        );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
