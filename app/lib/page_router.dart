import 'package:flutter/material.dart';
import 'package:app/pages/intro_page.dart';
import 'package:app/pages/yokai_page.dart';

class PageRouter extends StatefulWidget {
  PageRouter({Key? key}) : super(key: key);

  String page = "intro";

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PageRouter> {
  Map<String, Widget> get pages => {
        "intro": IntroPage(updatePage),
        "yokai": YokaiPage(updatePage),
      };

  Widget getPage() {
  Widget? page;
  if (widget.page == "yokai") {
    page = KeyedSubtree(key: const ValueKey("yokai"), child: pages["yokai"]!);
  } else {
    page = KeyedSubtree(key: const ValueKey("intro"), child: pages["intro"]!);
  }
  return page ?? const SizedBox();
}

  void updatePage(String page) {
    setState(() {
      widget.page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300), // Transition duration
      child: getPage(),
    );
  }
}
