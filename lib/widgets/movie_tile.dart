import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/movie_model.dart';
import '../screens/details_page.dart';

class MovieTile extends StatelessWidget {
  final Future<List<Movie>?>? future;
  const MovieTile({
    Key? key,
    // required this.movies,
    // required this.reviews,
    this.future,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: FutureBuilder<List<Movie>?>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 25),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 12,
                mainAxisExtent: 160,
              ),
              itemCount: snapshot.data!.length, //movies.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
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
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
