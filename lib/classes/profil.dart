import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/accueil.dart';
import 'package:flutter_application_1/classes/navbar.dart';
import 'package:flutter_application_1/classes/parametres.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _securityAnswerController = TextEditingController();
  TextEditingController _digicodeController = TextEditingController(); // Ajout du contrôleur pour le digicode
  String _selectedSecurityQuestion = 'Votre animal de compagnie préféré?';
  String _selectedAvatar = 'images/avatar1.png';
  List<String> avatars = [
    'images/chien.png',
    'images/grenouille.png',
    'images/singe.png',
    'images/tortue.png',
    'images/manchot.png',
    'images/tigre.png',
  ];

  List<String> securityQuestions = [
    'Votre animal de compagnie préféré?',
    'Quel est votre couleur préférée?',
    'Quel est le nom de votre professeur préféré?',
  ];

  @override
  void initState() {
    super.initState();
    loadUserData();
    _selectedAvatar = 'images/manchot.png';
  }

  void loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernameController.text = prefs.getString('username') ?? '';
      _passwordController.text = prefs.getString('password') ?? '';
      _selectedSecurityQuestion = prefs.getString('securityQuestion') ?? _selectedSecurityQuestion;
      _securityAnswerController.text = prefs.getString('securityAnswer') ?? '';
      _selectedAvatar = prefs.getString('avatar') ?? _selectedAvatar;
      _digicodeController.text = prefs.getString('digicode') ?? ''; // Charger le digicode
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon profil'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informations Personnelles',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            // Champ de sélection d'avatar
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage(_selectedAvatar),
                radius: 70,
              ),
            ),
            SizedBox(height: 20),
            // Boutons d'avatars
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: avatars.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatar = avatars[index];
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(avatars[index]),
                        radius: 30,
                        backgroundColor: _selectedAvatar == avatars[index]
                            ? Colors.blue
                            : Colors.transparent,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            // Champ de saisie pour le nom d'utilisateur
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Nom d\'utilisateur',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            // Champ de saisie pour le mot de passe
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mot de Passe',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            // Champ de saisie pour le digicode
            TextFormField(
              controller: _digicodeController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Digicode',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            // Menu déroulant pour la question de sécurité
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Question de sécurité',
                border: OutlineInputBorder(),
              ),
              value: _selectedSecurityQuestion,
              items: [
                for (String question in securityQuestions)
                  DropdownMenuItem(
                    value: question,
                    child: Text(
                      question,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedSecurityQuestion = value.toString();
                });
              },
            ),
            SizedBox(height: 10),
            // Champ de saisie pour la réponse à la question de sécurité
            TextFormField(
              controller: _securityAnswerController,
              decoration: InputDecoration(
                labelText: 'Réponse à la question de sécurité',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('username', _usernameController.text);
                await prefs.setString('password', _passwordController.text);
                await prefs.setString('securityQuestion', _selectedSecurityQuestion);
                await prefs.setString('securityAnswer', _securityAnswerController.text);
                await prefs.setString('avatar', _selectedAvatar);
                await prefs.setString('digicode', _digicodeController.text);

                Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                      builder: (context) =>const NavBar(title:"acceuil"), 
                      ),
                   );
                 
              },
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
