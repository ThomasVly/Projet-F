import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/chargement.dart';
import 'package:flutter_application_1/classes/digicode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chargement.dart';

class InscriptionPage extends StatefulWidget {
  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _securityAnswerController = TextEditingController();
  String _selectedSecurityQuestion =
      'Quel est le nom de votre animal de compagnie?'; // Variable pour stocker la question sélectionnée

  // Liste de questions de sécurité, à personnaliser selon vos besoins
  List<String> securityQuestions = [
    'Quel est le nom de votre animal de compagnie?',
    'Quel est votre couleur preferée?',
    'Quel est le nom de votre professeur préféré?',
  ];
  void initState() {
    super.initState();
    // Vérifier si l'utilisateur est déjà enregistré lors du lancement de l'application
    checkIfUserIsRegistered();
  }

  void checkIfUserIsRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isRegistered = prefs.getBool("isRegistered") ?? false;
    if (isRegistered) {
      // Rediriger l'utilisateur vers la page d'accueil si déjà enregistré
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const DigicodePage(
                title:
                    "Accueil")), // Remplacez MyHomePage() par votre page d'accueil
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/logo.png'),
                ),
              ),
            ),
          ),
          Positioned(
            top: 300, // Adjust the value based on your design
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bienvenue dans ton journal intime',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 148, 110, 218),
                  ),
                ),
                Text(
                  "Crée ton profil pour t'exprimer en toute intimité",
                  style: TextStyle(
                    letterSpacing: 1,
                  ),
                ),

                // Add other widgets as needed
              ],
            ),
          ),
          Positioned(
            top: 400,
            child: Container(
              height: 450,
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color.fromARGB(179, 187, 127, 199),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Champ de saisie pour le nom d'utilisateur
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nom d\'utilisateur',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  // Champ de saisie pour le code chiffré
                  // Champ de saisie pour le code chiffré
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Code chiffré',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Question de sécurité',
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedSecurityQuestion,
                      items: securityQuestions.map((question) {
                        return DropdownMenuItem(
                          value: question,
                          child: Text(question),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedSecurityQuestion = value.toString();
                        });
                      },
                    ),
                  ),

                  // Champ de saisie pour la réponse à la question de sécurité
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Réponse à la question de sécurité',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  // Bouton pour soumettre les informations
                  ElevatedButton(
                    onPressed: () async {
                      // Enregistrer les informations de l'utilisateur dans SharedPreferences
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString(
                          'username', _usernameController.text);
                      await prefs.setString(
                          'password', _passwordController.text);
                      await prefs.setString(
                          'securityQuestion', _selectedSecurityQuestion);
                      await prefs.setString(
                          'securityAnswer', _securityAnswerController.text);
                      await prefs.setBool('isRegistered',
                          true); // Marquer l'utilisateur comme enregistré

                      // Rediriger l'utilisateur vers la page d'accueil
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>DigicodePage(
                              title:
                                  "Accueil"), // Assurez-vous de passer le titre correctement
                        ),
                      );
                    },
                    child: Text('Valider'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
