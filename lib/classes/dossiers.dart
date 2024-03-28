import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class DossiersPage extends StatefulWidget {
  @override
  _DossiersPageState createState() => _DossiersPageState();
}

class _DossiersPageState extends State<DossiersPage> {
  List<String> dossiers = ['Dossier Favoris']; // Liste des dossiers

  final DateTime startDate = DateTime(2020, 1, 1);
  final DateTime endDate = DateTime(2025, 1, 1);
  List<String> stockEmo = [];
  List<String> stockTxt = [];

  @override
  void initState() {
    super.initState();
  }

  void retrieveNotesList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (DateTime date_i = startDate;
    date_i.isBefore(endDate);
    date_i = date_i.add(const Duration(days: 1))) {
      String? noteValue =
      prefs.getString(DateFormat('dd/MM/yyyy').format(date_i));
      if (noteValue != null) {
        if (noteValue.split("<>")[5] == "true"){stockEmo.add(noteValue.split("<>")[3]);stockTxt.add(noteValue.split("<>")[0]);}

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoris'),
      ),
      body: ListView.builder(
        itemCount: dossiers.length,
        itemBuilder: (BuildContext context, int index) {
          return ListView.builder(
             itemCount: stockEmo.length,
            itemBuilder: (context, index) {
            return ListTile(
               leading: Text(
              stockEmo[index], // Assuming emotions are emoji characters
              style: TextStyle(fontSize: 40),
               ),
               subtitle: Text(
                  "${DateFormat(stockTxt[index])}",
                  style: TextStyle(fontSize: 40),
                  )
              );
              }
             );
            }
      ),
    );
  }
}
