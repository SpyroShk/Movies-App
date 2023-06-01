import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/cast_model.dart';

class LoadCasts extends StatelessWidget {
  final Future<List<Cast>?>? future;
  const LoadCasts({Key? key, this.future}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cast>?>(
      future: future,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Text(
                    'No Casts',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                )
              : GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 150,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl: snapshot.data![index].profileUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/avatar.png',
                            height: 100,
                            width: 100,
                            // fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          snapshot.data![index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        )
                      ],
                    );
                  },
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
