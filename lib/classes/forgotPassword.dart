import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/classes/digicode.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

String questionText = 'Quelle est la couleur ?';

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

            SizedBox(height: screenHeight * 0.1,),

            // Affichage du logo et du nom de l'application
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'images/logo_forgot_password.png',
                      width: screenWidth * 0.20,
                      height: screenHeight * 0.10,
                    ),
                    SizedBox(width: screenWidth * 0.05), // Ajoute un espace entre l'image et le texte
                    const Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Mot de passe oublié ?",
                          style: TextStyle(fontSize: 32.0, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20.0),

            SizedBox(
              width : screenWidth * 0.8,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: selectBlue,
                ),
                child : Text(
                  questionText,
                  style: const TextStyle(fontSize: 24.0, color: Colors.white),
                ),
              ),
            ),

            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: PasswordInput(controller: passwordController, screenHeight: screenHeight,),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.1,),


            // Bouton "Vérifier"
            TextButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Définir un rayon de coin
                ),
              ),
              child: Container(
                width: screenWidth * 0.5,
                height: screenHeight * 0.075,
                decoration: BoxDecoration(
                  color: Colors.green, // Couleur de fond fixe
                  borderRadius: BorderRadius.circular(20.0), // Définir un rayon de coin
                ),
                alignment: Alignment.center,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown, // Ajuste la taille du texte pour s'adapter à la boîte
                    child: Text(
                      'Valider',
                      style: TextStyle(fontSize: 24.0, color: Colors.white),
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
      title: 'Mot de passe oublié App',
      home: ForgotPasswordPage(title: 'Mot de passe oublié'),
    ));
  }
}

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  final double screenHeight; // Nouvelle variable membre

  const PasswordInput({
    Key? key,
    required this.controller,
    required this.screenHeight, // Ajouter la variable membre dans le constructeur
  }) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  @override
  Widget build(BuildContext context) {
    final maxLines = 5;

    return Container(
      margin: EdgeInsets.all(12),
      height: maxLines * 24.0,
      child: TextField(
        maxLines: maxLines,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(filled: true, hintText: 'Enter a message'),
      ),
    );
  }
}

