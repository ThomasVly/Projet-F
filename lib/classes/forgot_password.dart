import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/digicode.dart';
import 'package:flutter_application_1/classes/mot_de_passe.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late bool _isDarkMode =false;
  @override
  void initState() {
    super.initState();
    _loadTheme();
    retrieveBoolValue();
    retrieveSecretQuestion();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)!.isCurrent) {
      _loadTheme();
    }
  }

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getDouble('theme') == 1.0;
    });
  }

  String errorText = ' ';
  late String questionText = '';
  late String answerText = '';

  int nbEssais = 3;

  bool showPasswordFields = false;
  late bool digicodeForgot;
  late bool passwordForgot;

  void checkInput(String input) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? answerValue = prefs.getString("securityAnswer");
    setState(() {
      if (answerValue != null) {
        answerText = answerValue;
      }
    });
    
    if (input == answerText) {
      nbEssais = 3;
      setState((){
        showPasswordFields = true;
        errorText = ' ';
      });
    } else {
      if (nbEssais > 1) {
        nbEssais = nbEssais - 1;
        setState(() {
          errorText = '$input est une mauvaise réponse.\n Il vous reste $nbEssais essais';
        });
      } else if (nbEssais == 0) {
        setState(() {
          errorText = '$input est une mauvaise réponse.\n Il ne vous reste plus aucun essais';
        });
      }
    }
  }

  void checkPassword(String password, String confirmPassword) async {
    if (password != confirmPassword) {
      if (digicodeForgot){
        setState(() {
          errorText = 'Les digicodes ne correspondent pas.';
        });
      }
      else if (passwordForgot){
        setState(() {
          errorText = 'Les mots de passe ne correspondent pas.';
        });
      }
    } else if (password == '' || confirmPassword == ''){
      if (digicodeForgot){
        setState(() {
          errorText = 'Veuillez remplir le digicode et sa confirmation';
        });
      }
      else if (passwordForgot){
        setState(() {
          errorText = 'Veuillez remplir le mot de passe et sa confirmation';
        });
      }
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (digicodeForgot){
        await prefs.setString(
          'digicode', password);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DigicodePage(title: "Mot de passe"),
          ),
        );
      }
      else if (passwordForgot){
        await prefs.setString(
          'password', password);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MotDePassePage(title: "Mot de passe"),
          ),
        );
      }
    }
  }
  

  retrieveBoolValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? bool_value = prefs.getBool("digicodeForgot");
    bool? bool_value2 = prefs.getBool("passwordForgot");
    if (bool_value != null) {
      setState(() {
        digicodeForgot = bool_value;
      });
    }
    if (bool_value2 != null) {
      setState(() {
        passwordForgot = bool_value2;
      });
    }
  }

  retrieveSecretQuestion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? questionValue = prefs.getString("securityQuestion");
    if (questionValue != null){
      setState(() {
        questionText = questionValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    const Color selectBlue =  Color(0xff1774CA);
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
                      _isDarkMode?
                      'images/whitelogo_forgot_password.png'
                      : 'images/blacklogo_forgot_password.png',
                      width: screenWidth * 0.20,
                      height: screenHeight * 0.10,
                    ),
                    SizedBox(width: screenWidth * 0.05), // Ajoute un espace entre l'image et le texte
                    const Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Mot de passe oublié ?",
                          style: TextStyle(fontSize: 32.0),
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
                } else if (showPasswordFields && passwordForgot) {
                  return Column(
                    children: [

                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          errorText,
                          style: const TextStyle(fontSize: 24.0, color: Colors.red),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.05,),

                      Container(
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          color: selectBlue,// Couleur de fond fixe
                          borderRadius: BorderRadius.circular(10.0), // Définir un rayon de coin
                        ),
                        alignment: Alignment.center,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: FittedBox(
                            fit: BoxFit.scaleDown, // Ajuste la taille du texte pour s'adapter à la boîte
                            child: Text(
                              'Nouveau mot de passe :',
                              style: TextStyle(fontSize: 24.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      // Boite de texte pour le nouveau mot de passe
                      TextInput(controller: newPasswordController),

                      SizedBox(height: screenHeight * 0.05,),

                      Container(
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          color: selectBlue,// Couleur de fond fixe
                          borderRadius: BorderRadius.circular(10.0), // Définir un rayon de coin
                        ),
                        alignment: Alignment.center,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: FittedBox(
                            fit: BoxFit.scaleDown, // Ajuste la taille du texte pour s'adapter à la boîte
                            child: Text(
                              'Confirmer le mot de passe :',
                              style: TextStyle(fontSize: 24.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      // Boite de texte pour la confirmation du mot de passe
                      TextInput(controller: confirmPasswordController),
                    ],
                  );
                } else if (showPasswordFields && digicodeForgot) {
                  return Column(
                    children: [

                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          errorText,
                          style: const TextStyle(fontSize: 24.0, color: Colors.red),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.05,),
                      Container(
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          color: selectBlue,// Couleur de fond fixe
                          borderRadius: BorderRadius.circular(10.0), // Définir un rayon de coin
                        ),
                        alignment: Alignment.center,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: FittedBox(
                            fit: BoxFit.scaleDown, // Ajuste la taille du texte pour s'adapter à la boîte
                            child: Text(
                              'Nouveau digicode :',
                              style: TextStyle(fontSize: 24.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      // Boite de texte pour le nouveau mot de passe
                      TextInput(controller: newPasswordController),

                      SizedBox(height: screenHeight * 0.05,),

                      Container(
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          color: selectBlue,// Couleur de fond fixe
                          borderRadius: BorderRadius.circular(10.0), // Définir un rayon de coin
                        ),
                        alignment: Alignment.center,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: FittedBox(
                            fit: BoxFit.scaleDown, // Ajuste la taille du texte pour s'adapter à la boîte
                            child: Text(
                              'Confirmer le digicode :',
                              style: TextStyle(fontSize: 24.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      // Boite de texte pour la confirmation du mot de passe
                      TextInput(controller: confirmPasswordController),
                    ],
                  );
                } else {
                  return const Column(
                    children: [
                      Text(
                        'ERROR',
                      )
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

