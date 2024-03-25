import 'dart:convert';
import 'dart:html' as html;

import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  late TextEditingController _controllertitre;
  late TextEditingController _controllertexte;
  DateTime? _selectedDate;

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
              maxLines: 20,
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
          ],
        ),
      ),
    );
  }
}
