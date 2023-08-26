import 'package:flutter/material.dart';
import 'package:app/pages/intro_page.dart';
import 'package:app/pages/yokai_page.dart';
import './components/yokai.dart';
import './pages/yokai_entry.dart';

class PageRouter extends StatefulWidget {
  PageRouter({Key? key}) : super(key: key);

  String page = "intro";

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PageRouter> {
  Yokai? selectedYokai;

  Map<String, Widget> get pages => {
        "intro": IntroPage(updatePage),
        "yokai": YokaiPage(updatePage, updateSelectedYokaiandNavigate),
      };

 Widget getPage() {
  Widget? page;
  if (widget.page == "yokai") {
    page = KeyedSubtree(key: const ValueKey("yokai"), child: pages["yokai"]!);
  } else if (widget.page == "intro") {
    page = KeyedSubtree(key: const ValueKey("intro"), child: pages["intro"]!);
  } else if (widget.page == "entry" && selectedYokai != null) {
    page = KeyedSubtree(key: const ValueKey("entry"), child: YokaiEntry(yokai: selectedYokai!, updatePage: updatePage)); // Use ! here
  }
  return page ?? const SizedBox();
}



  void updatePage(String page) {
    setState(() {
      widget.page = page;
    });
  }

  void updateSelectedYokaiandNavigate(Yokai yokai) {
    setState(() {
      selectedYokai = yokai;
      widget.page = "entry";
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
