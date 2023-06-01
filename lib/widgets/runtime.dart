import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/movie_model.dart';
import '../model/runtime_model.dart';

class Runtimes extends ConsumerWidget {
  final Movie movies;
  final Future<List<Runtime>?>? future;
  const Runtimes({Key? key, this.future, required this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      height: 20,
      width: 70,
      child: FutureBuilder<List<Runtime>?>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Text(
                      "${snapshot.data![index].runtime} Minutes",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF92929D),
                        fontSize: 12,
                      ),
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
