import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/myHomePage.dart';

class DigicodePage extends StatefulWidget {
  const DigicodePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DigicodePage> createState() => _DigicodePageState();
}

class _DigicodePageState extends State<DigicodePage> {
  String _input = ''; // Variable pour stocker les chiffres entrés

  // Fonction pour ajouter un chiffre au code entré
  void _addToInput(String digit) {
    if (_input.length <6) {
      setState(() {
        _input += digit;
      });
    }
    if (_input.length == 6) {
      
      print(_input);
      checkInput();
    }
  }

  // Fonction pour effacer le code entré
  void _clearInput() {
    setState(() {
      _input = '';
    });
  }

  // Fonction pour vérifier le code entré
  void checkInput() {
    if (_input == '123456') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>const MyHomePage(title:"accueil"), 
        ),
      );
    }
    else {
      _input = "ERROR!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'images/logo.png',
                  width: 80,
                  height: 80,
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            // Affichage du code entré
            Text(
              'Code:  ${_input.split('').join(' ')}' + ' _ ' * (6 - _input.length),
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20.0),
            // Cadran de 3x3 boutons
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              children: List.generate(9, (index) {
                int digit = index + 1;
                return ElevatedButton(
                  onPressed: () => _addToInput(digit.toString()),
                  child: Text('$digit'),
                );
              }),
            ),
            const SizedBox(height: 20.0),
            // Bouton pour le chiffre 0
            ElevatedButton(
              onPressed: () => _addToInput('0'),
              child: const Text('0'),
            ),
            const SizedBox(height: 20.0),
            // Bouton pour effacer le code entré
            ElevatedButton(
              onPressed: _clearInput,
              child: const Text('Effacer'),
            ),
        ],
      ),
    )
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Digicode App',
    home: DigicodePage(title: 'Digicode'),
  ));
}
