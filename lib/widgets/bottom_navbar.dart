import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie/provider/page_index_provider.dart';
import 'package:movie/screens/home_page.dart';
import 'package:movie/screens/search_page.dart';
import 'package:movie/screens/watchlist_page.dart';

class BottomNavbar extends ConsumerStatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends ConsumerState<BottomNavbar> {
  final List<Widget> screens = const [
    HomePage(),
    SearchPage(),
    WatchlistPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(pageIndexProvider);
    return Scaffold(
      body: screens.elementAt(selectedIndex),
      bottomNavigationBar: Container(
        height: 78,
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.blue, width: 2.0))),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          currentIndex: selectedIndex,
          backgroundColor: const Color(0xFF242A32),
          selectedItemColor: Colors.blue,
          unselectedItemColor: const Color(0xFF67686D),
          onTap: (index) {
            ref.read(pageIndexProvider.notifier).state = index;
          },
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: SvgPicture.asset('assets/icons/nav/Home.svg'),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: SvgPicture.asset('assets/icons/nav/Home1.svg'),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: SvgPicture.asset('assets/icons/nav/Search.svg'),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: SvgPicture.asset('assets/icons/nav/Search1.svg'),
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: SvgPicture.asset('assets/icons/nav/Save.svg'),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: SvgPicture.asset('assets/icons/nav/Save1.svg'),
              ),
              label: 'Watch list',
            ),
          ],
        ),
      ),
    );
  }
}
