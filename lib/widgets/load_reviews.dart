import 'package:flutter/material.dart';
import '../model/review_model.dart';

class LoadReviews extends StatelessWidget {
  final Future<List<Review>?>? future;
  // final Movie movies;
  const LoadReviews({
    Key? key,
    // required this.movies,
    this.future,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Review>?>(
      future: future,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Text(
                    'No Reviews',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'assets/images/avatar.png',
                              height: 44,
                              width: 44,
                              // fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              snapshot.data![index].rating.toString(),
                              style: const TextStyle(
                                color: Color(0xff0296E5),
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data![index].author,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 260,
                              child: Text(
                                snapshot.data![index].comment,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
