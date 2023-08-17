import 'package:flutter/material.dart';

class YokaiListing extends StatelessWidget {
  const YokaiListing(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}