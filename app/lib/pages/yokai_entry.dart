import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "./../components/yokai.dart";

class YokaiEntry extends StatelessWidget {
  YokaiEntry({required this.yokai, required this.updatePage, Key? key})
      : super(key: key);

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

  final void Function(String) updatePage;
  final Yokai yokai;

  Widget buildImage(String path, String name, int index) {
    String imagePath = 'assets/$path/$index-$name.jpg';
    return Image.asset(imagePath);
  }

  Widget buildIcon(String path, int index) {
    String imagePath = 'assets/$path/$index.png';
    return Image.asset(imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            updatePage("yokai");
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Row(
              children: [
                buildIcon("icons", yokai.number),
                const SizedBox(width: 10),
                Text(
                  yokai.name,
                  style: GoogleFonts.pacifico(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 112, 93, 218),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              color: colorMap[yokai.yokaiClass],
              child: Center(
                child: buildImage("images", yokai.name, yokai.number),
              ),
            ),
            // General Info Section
            buildSection('General Info', [
              'Name: ${yokai.name}',
              'Class: ${yokai.yokaiClass}',
              // add other general info here
            ]),
            // Stats Section
            buildSection('Stats', [
              'HP: ${yokai.HP}',
              'Attack: ${yokai.strength}',
              // add other stats here
            ]),
            // Attacks/Techniques Section
            buildSection('Attacks/Techniques', [
              'Technique: ${yokai.technique}}',
              'Soultimate: ${yokai.soultimate}',
              // add other attacks/techniques here
            ]),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 28, 197, 253),
    );
  }
}

Widget buildSection(String title, List<String> details) {
  return Container(
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        ...details.map((detail) => Text(
              detail,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: Colors.black54,
              ),
            )),
      ],
    ),
  );
}
