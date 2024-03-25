import 'dart:convert';
import 'dart:html' as html;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  bool isButtonSelected = false; 
  late TextEditingController _controllertitre;
  late TextEditingController _controllertexte;
  late SharedPreferences _prefs;
  DateTime? _selectedDate;
  late List<bool> isButtonSelectedList = List.filled(_emotions.length, false);
  final List<Map<String, dynamic>> _emotions = [
    {'name': 'Joie', 'emoji': '😊'},
    {'name': 'Tristesse', 'emoji': '😢'},
    {'name': 'Colère', 'emoji': '😡'},
    {'name': 'Amour', 'emoji': '😍'},
    {'name': 'Choc', 'emoji': '😱'},
    {'name': 'Peur', 'emoji': '😖'},
  ];
  List<String> tags = []; 
  @override
  void initState() {
    super.initState();
    _controllertitre = TextEditingController();
    _controllertexte = TextEditingController();
  }

  @override
  void dispose() {
    _controllertitre.dispose();
    _controllertexte.dispose();
    super.dispose();
  }


void saveNote() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  int index = 0;
  String emoji;
  String titre = _controllertitre.text;
  String texte = _controllertexte.text;
  for (int i = 0; i < isButtonSelectedList.length; i++) {
    if (isButtonSelectedList[i]) {
      index = i;
      break; 
    }
  }

  emoji = _emotions[index]['name'];
  String dateString = '$_selectedDate'; 
  String date = dateString;
  prefs.setString(date,"titre : $titre <>, texte : $texte <>, #tag : $tags <>, emoji : $emoji <>");
  debugPrint(prefs.getString(date));
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Note enregistrée'),
          content: Text('Votre note a été enregistrée avec succès.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  
}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              readOnly: true,
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != _selectedDate) {
                  setState(() {
                    _selectedDate = picked;
                  });
                }
              },
              controller: TextEditingController(
                text: _selectedDate != null
                    ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                    : '',
              ),
              decoration: InputDecoration(
                hintText: 'Sélectionner une date',
              ),
            ),
            TextField(
              controller: _controllertitre,
              decoration: InputDecoration(
                hintText: 'Titre de la note',
              ),
              onSubmitted: (String value) {
                debugPrint(value);
              },
            ),
            SizedBox(height : 20),
            TextField(
              controller: _controllertexte,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Texte de la note',
                // Vous pouvez utiliser le style pour définir la taille de la police
                hintStyle: TextStyle(fontSize: 16.0), // Taille de la police
                // Vous pouvez utiliser contentPadding pour définir le remplissage du contenu
                contentPadding: EdgeInsets.all(10.0), // Remplissage du contenu
                // Vous pouvez utiliser border pour définir le style de la bordure
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // Rayon de la bordure
                ),
              ),
              onSubmitted: (String value) {
                debugPrint(value);
              },
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8.0, // Espacement horizontal entre les boutons de tag
              runSpacing: 8.0, // Espacement vertical entre les lignes de boutons de tag
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String newTag = ''; // Variable pour stocker le nouveau tag saisi

                        return AlertDialog(
                          title: Text('Ajouter un Tag'),
                          content: TextField(
                            onChanged: (value) {
                              newTag = value; 
                            },
                            decoration: InputDecoration(
                              hintText: 'Entrez un tag',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); 
                              },
                              child: Text('Annuler'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  tags.add(newTag);
                                });
                                Navigator.pop(context); 
                              },
                              child: Text('Enregistrer'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('+ Tag'),
                ),
                // Afficher les boutons de tag
                ...tags.map((tag) => ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tags.remove(tag);
                    });
                  },
                  child: Text(tag + ' X'),
                )),
              ],
            ),

            Row(
              children: List.generate(
                _emotions.length,
                (index) => IconButton(
                  onPressed: () {
                    setState(() {
                      // Parcourir la liste des boutons et définir l'état à false sauf pour celui cliqué
                      for (int i = 0; i < isButtonSelectedList.length; i++) {
                        if (i == index) {
                          isButtonSelectedList[i] = true;
                        } else {
                          isButtonSelectedList[i] = false;
                        }
                      }
                    });
                    // Action à effectuer lors du clic sur le bouton
                    final emotion = _emotions[index];
                    final name = emotion['name'];
                    final emoji = emotion['emoji'];
                    debugPrint('$name : $emoji');
                  },
                  icon: Text(
                    _emotions[index]['emoji'],
                    style: TextStyle(fontSize: isButtonSelectedList[index] ? 48 : 24),
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: saveNote,
                  child: Text("sauvegarder"))
              ]
            )
          ],
        ),
      ),
    );
  }
}
