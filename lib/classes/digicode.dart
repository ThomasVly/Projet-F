import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/mot_de_passe.dart';
import 'package:flutter_application_1/classes/navbar.dart';

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
      checkInput();
    }
    if (_input.length >6) {
      _clearInput();
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
          builder: (context) =>const NavBar(title:"accueil"), 
        ),
      );
    }
    else {
      _input = "ERROR!";
    }
  }

  double calculateButtonSizeWidth(BuildContext context, int gridColumns) {
    double screenWidth = MediaQuery.of(context).size.width;
    double gridWidth = screenWidth * 0.8; // Utilise 80% de la largeur de l'écran pour la grille
    double buttonSize = gridWidth / gridColumns; // Calcule la taille des boutons en fonction du nombre de colonnes
    return buttonSize;
  }

  double calculateButtonSizeHeight(BuildContext context, int gridColumns) {
    double screenHeight = MediaQuery.of(context).size.height;
    double gridHeight = screenHeight * 0.4; // Utilise 80% de la largeur de l'écran pour la grille
    double buttonSize = gridHeight / gridColumns; // Calcule la taille des boutons en fonction du nombre de colonnes
    return buttonSize;
  }

  @override
  Widget build(BuildContext context) {

    double buttonSizeWidth = calculateButtonSizeWidth(context, 3);
    double buttonSizeHeight = calculateButtonSizeHeight(context, 3);
    const Color selectBlue =  Color(0xff1774CA);
    const Color unselectedGrey = Color(0xffD9D9D9);

    return Scaffold(
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Affichage du logo et du nom de l'application
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'images/logo.png',
                      width: buttonSizeWidth * 0.6,
                      height: buttonSizeHeight * 0.6,
                    ),
                    SizedBox(width: buttonSizeWidth * 0.1), // Ajoute un espace entre l'image et le texte
                    const Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "[Insérer nom de l'application]",
                          style: TextStyle(fontSize: 24.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),


            //SizedBox(height: buttonSizeHeight * 0.05),

            //Affichage du selecteur entre digicode et mdp
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bouton digicode
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: (){},
                    child: Container(
                      width: buttonSizeWidth*0.7,
                      height: buttonSizeHeight*0.7,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectBlue,
                        border: Border.all(color: Colors.white, width: 3.0),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'images/digicode.png',
                        width: buttonSizeWidth*0.45,
                        height: buttonSizeHeight*0.45,
                      ),
                    ),
                  ),
                ),

                // Bouton MDP
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MotDePassePage(title: "Mot de passe"),
                        ),
                      );
                    },
                    child: Container(
                      width: buttonSizeWidth*0.7,
                      height: buttonSizeHeight*0.7,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 3.0),
                      ),
                      alignment: Alignment.center,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown, // Ajuste la taille du texte pour s'adapter à la boîte
                          child: Text(
                            'MDP',
                            style: TextStyle(fontSize: 24.0, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //const SizedBox(height: 20.0),

            // Affichage du code entré
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Code:  ${_input.split('').join(' ')}' + ' _ ' * (6 - _input.length),
                style: const TextStyle(fontSize: 24.0),
              ),
            ),

            const SizedBox(height: 20.0),

            // Cadran de 3x3 boutons
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              children: List.generate(9, (index) {
                int digit = index + 1;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () => _addToInput(digit.toString()),
                    child: Container(
                      width: buttonSizeWidth,
                      height: buttonSizeHeight,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 3.0),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown, // Ajuste la taille du texte pour s'adapter à la boîte
                          child: Text(
                            '$digit',
                            style: const TextStyle(fontSize: 24.0, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),

            // Ligne pour les boutons "0" et "Effacer"
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Bouton "0"
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () => _addToInput('0'),
                    child: Container(
                      width: buttonSizeWidth,
                      height: buttonSizeHeight,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 3.0),
                      ),
                      alignment: Alignment.center,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown, // Ajuste la taille du texte pour s'adapter à la boîte
                          child: Text(
                            '0',
                            style: TextStyle(fontSize: 24.0, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Bouton "Effacer"
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: _clearInput,
                    child: Container(
                      width: buttonSizeWidth,
                      height: buttonSizeHeight,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 3.0),
                      ),
                      alignment: Alignment.center,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown, // Ajuste la taille du texte pour s'adapter à la boîte
                          child: Text(
                            'Effacer',
                            style: TextStyle(fontSize: 24.0, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Bouton "Mot de passe oublié ?"
            TextButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Définir un rayon de coin
                ),
              ),
              child: Container(
                width: buttonSizeWidth * 2,
                height: buttonSizeHeight * 0.5,
                decoration: BoxDecoration(
                  color: unselectedGrey, // Couleur de fond fixe
                  borderRadius: BorderRadius.circular(20.0), // Définir un rayon de coin
                ),
                alignment: Alignment.center,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown, // Ajuste la taille du texte pour s'adapter à la boîte
                    child: Text(
                      'Mot de passe oublié ?',
                      style: TextStyle(fontSize: 24.0, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void main() {
    runApp(MaterialApp(
      title: 'Digicode App',
      home: DigicodePage(title: 'Digicode'),
    ));
  }
}