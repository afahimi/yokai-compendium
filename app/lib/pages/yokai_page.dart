import 'package:app/components/yokai_listing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/yokai.dart';
import 'dart:convert';

Future<String> readYokaiFile() async {
  final String fileContent = await rootBundle.loadString('assets/yokai.json');
  return fileContent;
}

Future<List<Yokai>> fetchYokaiFromFirestore() async {
  final QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('yokai').get();
  List<Yokai> yokaiList = querySnapshot.docs
      .map((doc) => Yokai.fromJson(doc.data() as Map<String, dynamic>))
      .toList();
  return yokaiList;
}

Future<List<Yokai>> parseYokai() async {
  String jsonString = await readYokaiFile();
  List<dynamic> jsonList = jsonDecode(jsonString);
  List<Yokai> yokaiList = jsonList.map((json) => Yokai.fromJson(json)).toList();
  return yokaiList;
}

class YokaiPage extends StatefulWidget {
  final void Function(String) updatePage;
  final void Function(Yokai) updateSelectedYokaiandNavigate;

  const YokaiPage(this.updatePage, this.updateSelectedYokaiandNavigate,
      {Key? key})
      : super(key: key);

  @override
  _YokaiPageState createState() => _YokaiPageState();
}

class _YokaiPageState extends State<YokaiPage> {
  @override
  void initState() {
    super.initState();
    if (useFireStore) {
      initializeYokaiFireStore();
    } else {
      initializeYokai();
    }
  }

  bool useFireStore = true;

  Future<void> initializeYokai() async {
    yokaiList = await parseYokai();
    sortedYokaiList = sortYokai(yokaiList, selectedOption);
    filteredYokaiList = sortedYokaiList.where((yokai) {
      return yokai.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
    setState(() {});
  }

  Future<void> initializeYokaiFireStore() async {
    yokaiList = await fetchYokaiFromFirestore();
    sortedYokaiList = sortYokai(yokaiList, selectedOption);
    filteredYokaiList = sortedYokaiList.where((yokai) {
      return yokai.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
    setState(() {});
  }

  Widget _buildOptionTile(String value, String title) {
    return CheckboxListTile(
      title: Text(title),
      value: selectedOption == value,
      onChanged: (bool? isChecked) {
        if (isChecked == true) {
          setState(() {
            selectedOption = value;
            sortedYokaiList = sortYokai(yokaiList, selectedOption);
            filteredYokaiList = sortedYokaiList.where((yokai) {
              return yokai.name
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase());
            }).toList();
          });
        }
        // Close the drawer
        Navigator.pop(context);
      },
    );
  }

  List<Yokai> sortYokai(List<Yokai> yokaiList, String option) {
    List<Yokai> sortedList = List.from(yokaiList);
    if (option == 'By Compendium Number') {
      sortedList.sort((a, b) => a.number.compareTo(b.number));
    } else if (option == 'By Rank (Descending)') {
      const rankOrder = {'S': 0, 'A': 1, 'B': 2, 'C': 3, 'D': 4, 'E': 5};
      sortedList
          .sort((a, b) => rankOrder[a.rank]!.compareTo(rankOrder[b.rank]!));
    } else if (option == 'By Rank (Ascending)') {
      const rankOrder = {'E': 0, 'D': 1, 'C': 2, 'B': 3, 'A': 4, 'S': 5};
      sortedList
          .sort((a, b) => rankOrder[a.rank]!.compareTo(rankOrder[b.rank]!));
    } else if (option == 'By Name') {
      sortedList.sort((a, b) => a.name.compareTo(b.name));
    }
    return sortedList;
  }

  String selectedOption = 'By Compendium Number';
  String searchQuery = "";
  List<Yokai> yokaiList = [];
  List<Yokai> sortedYokaiList = [];
  List<Yokai> filteredYokaiList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 28, 197, 253),
              ),
              child: Center(
                child: Text(
                  'Filter Options',
                  style: GoogleFonts.pacifico(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            _buildOptionTile('By Compendium Number', 'By Compendium Number'),
            _buildOptionTile('By Rank (Descending)', 'By Rank (Descending)'),
            _buildOptionTile('By Rank (Ascending)', 'By Rank (Ascending)'),
            _buildOptionTile('By Name', 'By Name'),
          ],
        ),
      ),
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                widget.updatePage("intro");
              },
            ),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Search for a Yo-Kai!",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
                onChanged: (text) {
                  setState(() {
                    searchQuery = text;
                    filteredYokaiList = sortedYokaiList.where((yokai) {
                      return yokai.name
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase());
                    }).toList();
                  });
                },
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 112, 93, 218),
      ),
      backgroundColor: const Color.fromARGB(255, 28, 197, 253),
      body: Center(
        child: ListView.builder(
          itemCount: filteredYokaiList.length,
          itemBuilder: (context, index) {
            Yokai yokai = filteredYokaiList[index];
            return GestureDetector(
              onTap: () {
                widget.updateSelectedYokaiandNavigate(yokai);
              },
              child: YokaiListing(
                number: yokai.number,
                name: yokai.name,
                rank: yokai.rank,
                yokaiClass: yokai.yokaiClass,
              ),
            );
          },
        ),
      ),
    );
  }
}
