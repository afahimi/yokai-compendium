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
            buildTitle(
              '${yokai.number} - ${yokai.name}',
              const Color.fromARGB(255, 28, 197, 253),
            ),
            buildTextBox(
              [
                'Tribe: ${yokai.yokaiClass}',
                'Rank: ${yokai.rank}',
                'Element: ${yokai.element}',
                'Favorite Food: ${yokai.food}',
                'Phrase: ${yokai.phrase != "" ? '"${yokai.phrase}"' : 'N/A'}',
              ],
              context,
            ),
            const SizedBox(
              height: 5,
            ),
            buildTitle(
              "Stats",
              const Color.fromARGB(255, 253, 28, 106),
            ),
            buildTextBox(
              [
                'HP: ${yokai.HP[0]} - ${yokai.HP[1]}',
                'Attack: ${yokai.strength[0]} - ${yokai.strength[1]}',
                'Spirit: ${yokai.spirit[0]} - ${yokai.spirit[1]}',
                'Defense: ${yokai.defense[0]} - ${yokai.defense[1]}',
                'Speed: ${yokai.speed[0]} - ${yokai.speed[1]}',
              ],
              context,
            ),
            const SizedBox(
              height: 5,
            ),
            buildTitle(
              "Normal Attack",
              const Color.fromARGB(255, 253, 160, 28),
            ),
            buildTextBox(
              [
                'Name: ${yokai.normalAttack["name"]}',
                'Power: ${yokai.normalAttack["power"]}',
              ],
              context,
            ),
            const SizedBox(
              height: 5,
            ),
            buildTitle(
              "Technique",
              const Color.fromARGB(255, 28, 253, 73),
            ),
            buildTextBox(
              [
                'Name: ${yokai.technique["name"]}',
                'Power: ${yokai.technique["power"]}',
                'Range: ${yokai.technique["range"]}',
              ],
              context,
            ),
            const SizedBox(
              height: 5,
            ),
            buildTitle(
              "Soultimate",
              const Color.fromARGB(255, 230, 28, 253),
            ),
            buildTextBox(
              [
                'Name: ${yokai.soultimate["name"]}',
                'Attribute: ${yokai.soultimate["attribute"]}',
                'Power: ${yokai.soultimate["power"]}',
                'Effect: ${yokai.soultimate["effect"]}',
                'Range: ${yokai.soultimate["range"]}',
              ],
              context,
            ),
            const SizedBox(
              height: 5,
            ),
            buildTitle(
              "Inspirit",
              const Color.fromARGB(255, 253, 223, 28),
            ),
            buildTextBox(
              [
                'Name: ${yokai.inspirit["name"]}',
                'Effect: ${yokai.inspirit["effect"]}',
              ],
              context,
            ),
            const SizedBox(
              height: 5,
            ),
            buildTitle(
              "Skill",
              const Color.fromARGB(255, 253, 28, 111),
            ),
            buildTextBox(
              [
                'Name: ${yokai.skill["name"]}',
                'Effect: ${yokai.skill["effect"]}',
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

Widget buildTextBox(List<String> details, BuildContext context) {
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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

Widget buildTitle(String title, Color color) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Colors.black,
        width: 2,
      ),
    ),
    child: Text(
      title,
      style: GoogleFonts.roboto(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
