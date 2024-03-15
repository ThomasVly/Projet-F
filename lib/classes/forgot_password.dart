import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/mot_de_passe.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String errorText = ' ';
  String questionText = 'Quelle est la couleur ?';

  int nbEssais = 3;

  bool showPasswordFields = false;

  void checkInput(String input) {
    setState(() {
      
      if (input == 'BLEU') {
        nbEssais = 3;
        showPasswordFields = true;
      } else {
        errorText = '$input est une mauvaise réponse.\n Il vous reste $nbEssais essais';
        nbEssais = nbEssais - 1;
      }
    });
  }

  void checkPassword(String password, String confirmPassword) {
    setState(() {
      if (password != confirmPassword) {
        errorText = 'Les mots de passe ne correspondent pas.';
      } else {
        // Vous pouvez ajouter ici la logique pour réinitialiser le mot de passe
        errorText = 'Mot de passe réinitialisé avec succès.';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MotDePassePage(title: "Mot de passe"),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    const Color selectBlue =  Color(0xff1774CA);
    const Color unselectedGrey = Color(0xffD9D9D9);
    final TextEditingController textInputController = TextEditingController();
    final TextEditingController newPasswordController= TextEditingController();
    final TextEditingController confirmPasswordController= TextEditingController();

    return Scaffold(
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            SizedBox(height: screenHeight * 0.075,),

            // Affichage du logo et du nom de l'application
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'images/blacklogo_forgot_password.png',
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

            SizedBox(height: screenHeight * 0.05,),


            Builder(
              builder: (context) {
                if (!showPasswordFields) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: screenHeight * 0.075,),
                      // Boite d'affichage du texte d'erreur  
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          errorText,
                          style: const TextStyle(fontSize: 24.0, color: Colors.red),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05,),
                      // Boite d'affichage de la question secrète.
                      Container(
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          color: selectBlue,// Couleur de fond fixe
                          borderRadius: BorderRadius.circular(10.0), // Définir un rayon de coin
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: FittedBox(
                            fit: BoxFit.scaleDown, // Ajuste la taille du texte pour s'adapter à la boîte
                            child: Text(
                              questionText,
                              style: const TextStyle(fontSize: 24.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextInput(controller: textInputController),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05,),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      TextInput(controller: newPasswordController),
                      SizedBox(height: screenHeight * 0.05,),
                      TextInput(controller: confirmPasswordController),
                    ],
                  );
                }
              },
            ),

            // Bouton "Vérifier"
            TextButton(
              onPressed: (){
                if(!showPasswordFields){
                  String textInput = textInputController.text;
                  checkInput(textInput);
                }
                else {
                  String password = newPasswordController.text;
                  String confirmPassword = confirmPasswordController.text;
                  checkPassword(password, confirmPassword);
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Définir un rayon de coin
                ),
              ),
              child: Container(
                width: screenWidth * 0.35,
                height: screenHeight * 0.05,
                decoration: BoxDecoration(
                  color: Colors.green, // Couleur de fond fixe
                  borderRadius: BorderRadius.circular(10.0), // Définir un rayon de coin
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

            SizedBox(height: screenHeight * 0.05,),

            //Logo de l'application
            Flexible(
              child: Image.asset(
                'images/logo.png',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void main() {
    runApp(const MaterialApp(
      title: 'Mot de passe oublié App',
      home: ForgotPasswordPage(title: 'Mot de passe oublié'),
    ));
  }
}

class TextInput extends StatefulWidget {
  final TextEditingController controller;

  const TextInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    const maxLines = 5;

    return Container(
      margin: const EdgeInsets.all(12),
      height: maxLines * 24.0,
      decoration: const BoxDecoration(
        color: Color(0xffD9D9D9),
      ),
      child: TextField(
        controller: widget.controller,
        maxLines: maxLines,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(filled: true, hintText: 'Enter a message'),
      ),
    );
  }
}

