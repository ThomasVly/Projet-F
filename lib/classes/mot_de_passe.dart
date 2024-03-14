import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/classes/digicode.dart';
import 'package:flutter_application_1/classes/navbar.dart';

class MotDePassePage extends StatefulWidget {
  const MotDePassePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MotDePassePage> createState() => _MotDePassePageState();
}

class _MotDePassePageState extends State<MotDePassePage> {

  // Fonction pour vérifier le code entré
  void checkInput(String input) {
    if (input == 'motdepasse') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>const NavBar(title:"accueil"), 
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    const Color selectBlue =  Color(0xff1774CA);
    const Color unselectedGrey = Color(0xffD9D9D9);
    final TextEditingController passwordController = TextEditingController();

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
                      width: screenWidth * 0.1,
                      height: screenHeight * 0.1,
                    ),
                    SizedBox(width: screenWidth * 0.05), // Ajoute un espace entre l'image et le texte
                    const Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "[Insérer nom de l'application]",
                          style: TextStyle(fontSize: 24.0, color: Colors.black),
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
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DigicodePage(title: "Digicode"),
                        ),
                      );
                    },
                    child: Container(
                      width: screenWidth*0.18,
                      height: screenHeight*0.18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 3.0),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'images/digicode.png',
                        width: screenWidth*0.10,
                        height: screenHeight*0.10,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                // Bouton MDP
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: (){},
                    child: Container(
                      width: screenWidth*0.18,
                      height: screenHeight*0.18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectBlue,
                        border: Border.all(color: Colors.white, width: 3.0),
                      ),
                      alignment: Alignment.center,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown, // Ajuste la taille du texte pour s'adapter à la boîte
                          child: Text(
                            'MDP',
                            style: TextStyle(fontSize: 24.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20.0),

            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: PasswordInput(controller: passwordController),
                  ),
                  TextButton(
                    onPressed: () {
                      // Récupération du texte du champ de texte
                      String password = passwordController.text;
                      checkInput(password);
                    },
                    child: Container(
                      width: screenWidth*0.1,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Text(
                        '✔',
                        style: TextStyle(fontSize: 24.0, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
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
                width: screenWidth * 0.65,
                height: screenHeight * 0.05,
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
      title: 'MotDePasse App',
      home: MotDePassePage(title: 'MotDePasse'),
    ));
  }
}

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;

  const PasswordInput({Key? key, required this.controller}) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: widget.controller, // Utilisation du contrôleur passé en paramètre
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Entrer le mot de passe',
          labelText: 'Mot de passe',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}