import 'package:app/components/yokai_listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/yokai.dart';
import 'dart:convert';

Future<String> readYokaiFile() async {
  final String fileContent = await rootBundle.loadString('assets/yokai.json');
  return fileContent;
}

Future<List<Yokai>> parseYokai() async {
  String jsonString = await readYokaiFile();
  List<dynamic> jsonList = jsonDecode(jsonString);
  List<Yokai> yokaiList = jsonList.map((json) => Yokai.fromJson(json)).toList();
  return yokaiList;
}

class YokaiPage extends StatefulWidget {
  final void Function(String) updatePage;

  const YokaiPage(this.updatePage, {Key? key}) : super(key: key);

  @override
  _YokaiPageState createState() => _YokaiPageState();
}

class _YokaiPageState extends State<YokaiPage> {
  @override
  void initState() {
    super.initState();
    initializeYokai();
  }

  Future<void> initializeYokai() async {
    yokaiList = await parseYokai();
    filteredYokaiList = yokaiList.where((yokai) {
      return yokai.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
    setState(() {});
  }

  String searchQuery = "";
  List<Yokai> yokaiList = [];
  List<Yokai> filteredYokaiList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    filteredYokaiList = yokaiList.where((yokai) {
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
            return YokaiListing(
                number: yokai.number,
                name: yokai.name,
                rank: yokai.rank,
                yokaiClass: yokai.yokaiClass);
          },
        ),
      ),
    );
  }
}
