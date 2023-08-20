import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YokaiListing extends StatelessWidget {
  const YokaiListing({
    Key? key,
    required this.number,
    required this.name,
    required this.rank,
    required this.yokaiClass,
  }) : super(key: key);

  final int number;
  final String name;
  final String rank;
  final String yokaiClass;

  @override
  Widget build(BuildContext context) {
    final Map<String, Color> colorMap = {
      "Eerie": const Color.fromARGB(255, 148, 104, 152),
      "Brave": const Color.fromARGB(255, 228, 93, 58),
      "Charming": const Color.fromARGB(255, 233, 119, 141),
      "Heartful": const Color.fromARGB(255, 109, 174, 96),
      "Mysterious": const Color.fromARGB(255, 234, 220, 81),
      "Slippery": const Color.fromARGB(255, 96, 187, 215),
      "Shady": const Color.fromARGB(255, 65, 162, 214),
      "Tough": const Color.fromARGB(255, 235, 150, 96),
    };

    Widget buildImage(String path, int index) {
      String imagePath = 'assets/$path/$index.png';
      return Image.asset(imagePath);
    }

    return Container(
      decoration: BoxDecoration(
        color: colorMap[yokaiClass],
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                buildImage("icons", number),
                const SizedBox(width: 10),
                Text(
                  name,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Image.asset(
                  "assets/ranks/$yokaiClass.png",
                  width: 30,
                  height: 30,
                ),
                const SizedBox(width: 10),
                buildImage("attributes", number),
                const SizedBox(width: 10),
                Image.asset(
                  "assets/ranks/Rank_${rank}_icon.PNG.png",
                  width: 30,
                  height: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
