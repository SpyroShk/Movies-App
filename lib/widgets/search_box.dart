import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie/provider/page_index_provider.dart';

class SearchBox extends ConsumerStatefulWidget {
  final VoidCallback onSubmit;
  final bool isHomeScreen;
  final bool textEnabled;
  final TextEditingController? searchTextController;

  const SearchBox({
    Key? key,
    required this.onSubmit,
    this.isHomeScreen = false,
    this.searchTextController,
    required this.textEnabled,
  }) : super(key: key);

  @override
  ConsumerState<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends ConsumerState<SearchBox> {
  late FocusNode myFocusNode;
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    if (!widget.isHomeScreen) {
      myFocusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.isHomeScreen) {
          ref.read(pageIndexProvider.notifier).state = 1;
        } else {
          return;
        }
      },
      child: SizedBox(
        height: 42,
        child: TextField(
          enabled: widget.textEnabled,
          focusNode: myFocusNode,
          controller: widget.searchTextController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/appbar/Search2.svg',
                width: 15,
                height: 15,
              ),
              onPressed: () {
                widget.onSubmit();
                // if (widget.isHomeScreen) {
                //   ref.read(pageIndexProvider.notifier).state = 1;
                // } else {
                //   widget.onSubmit();
                // }
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            hintStyle: const TextStyle(
              color: Color(
                0xFF67686D,
              ),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            contentPadding: const EdgeInsets.only(
              left: 24,
            ),
            filled: true,
            fillColor: const Color(0xFF3A3F47),
            hintText: 'Search',
          ),
          onSubmitted: (_) => widget.onSubmit(),
        ),
      ),
    );
  }
}
