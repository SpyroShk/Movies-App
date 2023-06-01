import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie/provider/search_provider.dart';
import 'package:movie/widgets/custom_appbar.dart';
import '../notifer/search_notifier.dart';
import '../widgets/listview_ui.dart';
import '../widgets/search_box.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late TextEditingController _searchTextController;

  @override
  void initState() {
    _searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    // ignore: avoid_print
    print('Dispose used');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchedMovies = ref.watch(searchProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF242A32),
      appBar: CustomAppbar(
        title: 'Search',
        height: 120,
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/appbar/info-circle.svg',
            ),
          ),
          const SizedBox(width: 10),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: SearchBox(
              isHomeScreen: false,
              onSubmit: () {
                Future.microtask(
                  (() => searchedMovies
                      .loadSearchDetail(_searchTextController.text)),
                );
              },
              searchTextController: _searchTextController,
              textEnabled: true,
            ),
          ),
        ),
      ),
      body: Center(
        child: Consumer(
          builder: ((context, ref, child) {
            final searchDetails =
                ref.watch<SearchNotifier>(searchProvider).searchDetails;
            if (searchDetails == null) {
              return Container();
            } else if (searchDetails.isEmpty) {
              return SizedBox(
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/noresults.png'),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'We Are Sorry, We Can\n Not Find The Movie :(',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Find your movie by Type title,\n categories, years, etc ',
                      style: TextStyle(
                        color: Color(0xFF92929D),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            }
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: searchDetails.length,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              separatorBuilder: (context, index) => Container(
                height: 8,
              ),
              itemBuilder: ((context, index) {
                return ListviewUi(
                  movie: searchDetails[index],
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
