import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'design.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key, required this.title, required this.selectedDate}) : super(key: key);

  final String title;
  final DateTime selectedDate;

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  late File _imageFile = File('');
  late bool favori = false;
  bool isButtonSelected = false;
  String imagePath = '';
  late TextEditingController _controllertitre;
  late TextEditingController
      _controllertexte; // Déclaration de la variable _imageFile
  late SharedPreferences _prefs;
  late List<bool> isButtonSelectedList = List.filled(_emotions.length, false);
  
  late DateTime _selectedDate;
  
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
    late File _imageFile = File('');
    late bool favori = false;
    _selectedDate = widget.selectedDate;
    loadNote(_selectedDate);
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
    String date = DateFormat('dd/MM/yyyy').format(_selectedDate);
      String imagePath = _imageFile.path.isNotEmpty ? _imageFile.path : '';
    if (date.isNotEmpty &&
        titre.isNotEmpty &&
        texte.isNotEmpty &&
        emoji.isNotEmpty) {
      prefs.setString(date,
          "${titre}<>${texte}<>${tags}<>${emoji}<>${imagePath}<>${favori}");
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
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erreur'),
              content: Text(
                  'Vous devez au minimum entrer le titre, le texte, et la date'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    }
  }

  void loadNote(DateTime selectedDate) async {
    String emoji = '';
                  String dateString =
                      DateFormat('dd/MM/yyyy').format(_selectedDate!);
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String? noteData = prefs.getString(dateString);
                  if (noteData != null) {
                    // Analyser les données récupérées et mettre à jour les champs de titre, texte et tags
                    List<String> parts = noteData.split("<>");
                    _controllertitre.text = parts[0];
                    _controllertexte.text = parts[1];
                    if (parts.length >= 5) {
                      imagePath = parts[4];
                      if (parts[5] == 'true') {
                        favori = true;
                      } else {
                        favori = false;
                      }
                    } else {
                      imagePath = '';
                    }
                    emoji = parts[3];
                    for (int i = 0; i < _emotions.length; i++) {
                      if (_emotions[i]['name'] == emoji) {
                        setState(() {
                          isButtonSelectedList[i] = true;
                        });
                      } else {
                        setState(() {
                          isButtonSelectedList[i] = false;
                        });
                      }
                    }
                    String tagsString = parts[2];
                    tagsString = tagsString.substring(1, tagsString.length - 1);
                    setState(() {
                      tags = tagsString.split(", ");
                      _imageFile = File(imagePath);
                    });
                  } else {
                    _controllertitre.clear();
                    _controllertexte.clear();
                    imagePath = '';
                    for (int i = 0; i < _emotions.length; i++) {
                      isButtonSelectedList[i] = false;
                    }
                    setState(() {
                      tags.clear();
                    });
                  }
  }
  
  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Faire quelque chose avec l'image sélectionnée
      // Par exemple, afficher l'image dans votre interface utilisateur
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Notes',
                      style: TextStyle(
                        fontSize: 24, // Taille de la police en points
                        // Vous pouvez également spécifier d'autres styles de texte si nécessaire
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          favori = !favori;
                        });
                      },
                      child: Icon(
                        Icons.star,
                        color: favori ? Colors.yellow : Colors.grey,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: TextFormField(
                    readOnly: true,
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != _selectedDate) {
                        setState(() {
                          _imageFile = File('');
                          _selectedDate = picked;
                        });
                        loadNote(_selectedDate);
                      }
                    },
                    controller: TextEditingController(
                      text: '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Sélectionner une date',
                    ),
                  ),
                ),
                Container(
                  child: TextField(
                    controller: _controllertitre,
                    decoration: const InputDecoration(
                      hintText: 'Titre de la note',
                    ),
                    onSubmitted: (String value) {},
                  ),
                ),
            Container(
              decoration: AppDesign
                  .buildBackgroundDecoration(), // Couleur de fond de votre choix
              padding:
                  const EdgeInsets.all(13.0), // Rembourrage intérieur du conteneur
              child: SizedBox(
                height: 330,
                child: TextField(
                  controller: _controllertexte,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: 'Texte de la note',
                    hintStyle: const TextStyle(fontSize: 16.0),
                    contentPadding: const EdgeInsets.all(45.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  style: AppDesign.bodyStyle,
                  onSubmitted: (String value) {},
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0, // Espacement horizontal entre les boutons de tag
              runSpacing:
                  8.0, // Espacement vertical entre les lignes de boutons de tag
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String newTag =
                            ''; // Variable pour stocker le nouveau tag saisi

                        return AlertDialog(
                          title: const Text('Ajouter un Tag'),
                          content: TextField(
                            onChanged: (value) {
                              newTag = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Entrez un tag',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Annuler'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  tags.add(newTag);
                                });
                                Navigator.pop(context);
                              },
                              child: const Text('Enregistrer'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('+ Tag'),
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _emotions.length,
                (index) => IconButton(
                  onPressed: () {
                    setState(() {
                      for (int i = 0; i < isButtonSelectedList.length; i++) {
                        if (i == index) {
                          isButtonSelectedList[i] = true;
                        } else {
                          isButtonSelectedList[i] = false;
                        }
                      }
                    });
                    final emotion = _emotions[index];
                    final name = emotion['name'];
                    final emoji = emotion['emoji'];
                  },
                  icon: Text(
                    _emotions[index]['emoji'],
                    style: TextStyle(
                        fontSize: isButtonSelectedList[index] ? 48 : 24),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _getImage();
                },
                child: Icon(Icons.image),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _imageFile.path.isNotEmpty
                    ? Image.file(
                        _imageFile,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                    : Text(""),
                _imageFile.path.isNotEmpty
                    ? ElevatedButton(
                        onPressed: () {
                          setState(() {
                            imagePath = '';
                            _imageFile = File("");
                          });
                          String path = _imageFile.path;
                        },
                        child: Text('X'),
                      )
                    : Text(""),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              ElevatedButton(onPressed: saveNote, child: Text("Sauvegarder")),
            ]),
          ],
        ),
      ),
    )));
  }
}
