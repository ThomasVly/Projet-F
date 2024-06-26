import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/inscriptionPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'design.dart';
import 'package:flutter_application_1/classes/digicode.dart';

class Chargement extends StatefulWidget {
  const Chargement({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ChargementState createState() => _ChargementState();
}

class _ChargementState extends State<Chargement>
    with SingleTickerProviderStateMixin {
  late String username = "";
  late AnimationController _controller;

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
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });

    _controller.forward();

    retrieveStringValue();
    Future.delayed(const Duration(seconds: 3), () {
      checkIfUserIsRegistered();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => InscriptionPage(),
        ),
      );
    });
  }

  retrieveStringValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("username");
    if (value != null) {
      setState(() {
        username = value;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: AppDesign.buildBackgroundDecoration(),
        child: Stack(
          children: [
            // Logos en arrière-plan
            Positioned(
              left: 0,
              top: 0,
              child: Image.asset(
                'images/logo.png',
                width: screenSize.width / 4,
                height: screenSize.height / 4,
                color: const Color.fromARGB(255, 80, 79, 79).withOpacity(0.2),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Image.asset(
                'images/logo.png',
                width: screenSize.width / 4,
                height: screenSize.height / 4,
                color: const Color.fromARGB(255, 80, 79, 79).withOpacity(0.2),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset(
                'images/logo.png',
                width: screenSize.width / 4,
                height: screenSize.height / 4,
                color: const Color.fromARGB(255, 80, 79, 79).withOpacity(0.2),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Image.asset(
                'images/logo.png',
                width: screenSize.width / 4,
                height: screenSize.height / 4,
                color: const Color.fromARGB(255, 80, 79, 79).withOpacity(0.2),
              ),
            ),
            // Contenu au centre de la page
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Logo principal
                  Image.asset(
                    'images/logo.png',
                    width: screenSize.width * 0.8,
                    height: screenSize.height * 0.4,
                  ),
                  SizedBox(height: 18),
                  // Texte de bienvenue
                  Center(
                    child: Text(
                      "Bienvenue $username",
                      style: TextStyle(
                          fontSize: screenSize.width / 16, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 18),
                  Center(
                    child: Image.asset(
                      'images/gif-diary.gif',
                      width: screenSize.width / 3,
                      height: screenSize.height / 5,
                    ),
                  ),
                  // Barre de progressionv
                  LinearProgressIndicator(
                    value: _controller.value,
                    backgroundColor:
                        const Color.fromARGB(255, 22, 22, 22).withOpacity(0.5),
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 189, 66, 201)),
                  ),
                  SizedBox(height: 18),
                  // GIF centré
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
