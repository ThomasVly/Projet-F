import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/digicode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InscriptionPage extends StatefulWidget {
  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _digicodeController = TextEditingController();
  final TextEditingController _securityAnswerController = TextEditingController();
  String _selectedSecurityQuestion = 'Votre animal de compagnie préféré?';

  List<String> securityQuestions = [
    'Votre animal de compagnie préféré?',
    'Quel est votre couleur preferée?',
    'Quel est le nom de votre professeur préféré?',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
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
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(179, 187, 127, 199),
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
                      decoration: const InputDecoration(
                        labelText: 'Nom d\'utilisateur',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Mot de Passe',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextFormField(
                      controller: _digicodeController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Code chiffré',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: 'Question de sécurité',
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedSecurityQuestion,
                        style: const TextStyle(fontSize: 11),
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
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _securityAnswerController,
                      decoration: const InputDecoration(
                        labelText: 'Réponse à la question de sécurité',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        if (_digicodeController.text.length == 6) {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setString('username', _usernameController.text);
                          await prefs.setString('password', _passwordController.text);
                          await prefs.setString('digicode', _digicodeController.text);
                          await prefs.setString('securityQuestion', _selectedSecurityQuestion);
                          await prefs.setString('securityAnswer', _securityAnswerController.text);
                          await prefs.setBool('isRegistered', true);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DigicodePage(
                                title: "Accueil",
                              ),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Erreur"),
                                content: Text("Le digicode doit contenir exactement 6 caractères."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text('Valider'),
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
