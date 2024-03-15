import 'package:flutter/material.dart';
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
  String _selectedSecurityQuestion = 'Votre animal de compagnie préféré?';

  List<String> securityQuestions = [
    'Votre animal de compagnie préféré?',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bienvenue dans ton journal intime',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 148, 110, 218),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Crée ton profil pour t'exprimer en toute intimité",
                    style: TextStyle(
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Nom d\'utilisateur',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Code chiffré',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: 'Question de sécurité',
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedSecurityQuestion,
                        style: TextStyle(fontSize: 11),
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
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _securityAnswerController,
                      decoration: InputDecoration(
                        labelText: 'Réponse à la question de sécurité',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
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
                        await prefs.setBool('isRegistered', true);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DigicodePage(
                              title: "Accueil",
                            ),
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
      ),
    );
  }
}
