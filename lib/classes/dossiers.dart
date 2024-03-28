import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'event.dart';

class DossiersPage extends StatefulWidget {
  @override
  _DossiersPageState createState() => _DossiersPageState();
}

class _DossiersPageState extends State<DossiersPage> {
  String _searchText = '';
  Map<DateTime, List<Note>> notes = {};

  late final ValueNotifier<List<Note>> _selectedNotes;
  late final ValueNotifier<String?> _selectedEmotion =
      ValueNotifier<String?>(null);

  final List<Map<String, dynamic>> _emotions = [
    {'name': 'Joie', 'emoji': '😊'},
    {'name': 'Tristesse', 'emoji': '😢'},
    {'name': 'Colère', 'emoji': '😡'},
    {'name': 'Amour', 'emoji': '😍'},
    {'name': 'Choc', 'emoji': '😱'},
    {'name': 'Peur', 'emoji': '😖'},
  ];

  DateTime parseDate(String dateString) {
    List<String> parts = dateString.split('/');
    if (parts.length != 3) {
      throw FormatException('Invalid date format: $dateString');
    }
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs.getKeys().toList();

    for (String key in keys) {
      if (prefs.containsKey(key)) {
        dynamic value = prefs.get(key); // Récupérer la valeur associée à la clé
        if (value is String && value.contains("<>")) {
          // Traiter la valeur comme une chaîne de caractères
          List<String> parts = value.split("<>");
          if (parts.length >= 6) {
            String titre = parts[0];
            String texte = parts[1];
            List<String> tags = parts[2].split(", ");
            String emoji = parts[3];
            String favori = parts[5];
            DateTime date = parseDate(key);

            Note note = Note(
              titre,
              texte,
              emoji,
              date,
              tags: tags,
            );
            if (favori == "true"){
              if (notes.containsKey(date)) {
                notes[date]!.add(note);
              } else {
                notes[date] = [note];
              }
          }
          }
        } else {
        }
      }
    }

    setState(() {});
  }

  List<Note> _getNotes(String keyword, String selectedEmotion) {
    List<Note> filteredNotes = [];
    for (List<Note> dayNotes in notes.values) {
      for (Note note in dayNotes) {
        if (note.title.toLowerCase().contains(keyword.toLowerCase()) ||
            note.text.toLowerCase().contains(keyword.toLowerCase()) ||
            note.tags.any(
                (tag) => tag.toLowerCase().contains(keyword.toLowerCase()))) {
          filteredNotes.add(note);
        }
      }
    }
    return filteredNotes;
  }

  @override
  Widget build(BuildContext context) {
    List<Note> filteredNotes =
        _getNotes(_searchText, _selectedEmotion.value?.toString() ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text('Favoris'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredNotes.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          filteredNotes[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                            height: 4), // Espacement entre le titre et le texte
                        Text(
                          filteredNotes[index].text,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Wrap(
            children: _emotions.map((emotion) {
              return ListTile(
                title: Text(
                  emotion['name'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Text(
                  emotion['emoji'],
                  style: TextStyle(fontSize: 24),
                ),
                onTap: () {
                  // Appliquer le filtre correspondant à l'émotion
                  setState(() {
                    _selectedEmotion.value = emotion['name'];
                  });
                  // Appliquer le filtre correspondant à l'émotion
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
