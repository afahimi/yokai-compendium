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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Center(
                child: buildImage("images", yokai.name, yokai.number),
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 28, 197, 253),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                "${yokai.number} - ${yokai.name}",
                style: GoogleFonts.roboto(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            buildSection(
              'General Info',
              [
                'Name: ${yokai.name}',
                'Class: ${yokai.yokaiClass}',
                'Rank: ${yokai.rank}',
                'Element: ${yokai.element}',
                'Favorite Food: ${yokai.food}',
                'Phrase: ${yokai.phrase != "" ? '"${yokai.phrase}"' : 'N/A'}',
              ],
              context,
            ),
            buildSection(
              'Stats',
              [
                'HP: ${yokai.HP[0]} - ${yokai.HP[1]}',
                'Attack: ${yokai.strength[0]} - ${yokai.strength[1]}',
                'Spirit: ${yokai.spirit[0]} - ${yokai.spirit[1]}',
                'Defense: ${yokai.defense[0]} - ${yokai.defense[1]}',
                'Speed: ${yokai.speed[0]} - ${yokai.speed[1]}',
              ],
              context,
            ),
            buildSection(
              'Attacks/Techniques',
              [
                'Normal Attack: ${yokai.normalAttack["name"]}',
                'Technique: ${yokai.technique["name"]}',
                'Soultimate: ${yokai.soultimate["name"]}',
              ],
              context,
            ),
          ],
        ),
      ),
      backgroundColor: colorMap[yokai.yokaiClass],
    );
  }
}

Widget buildSection(String title, List<String> details, BuildContext context) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(
      top: 5.0,
      bottom: 5.0,
    ),
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
        const SizedBox(
          height: 10,
        ),
        ...details.map((detail) => Column(
              children: [
                Text(
                  detail,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            )),
      ],
    ),
  );
}
