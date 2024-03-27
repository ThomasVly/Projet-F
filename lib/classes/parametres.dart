import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/digicode.dart';
import 'package:flutter_application_1/classes/profilDigicode.dart';
import 'package:flutter_application_1/classes/themes.dart';
import 'package:flutter_application_1/classes/profil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'design.dart';

class Parametres extends StatefulWidget {
  const Parametres({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Parametres> createState() => _ParametresState();
}

class _ParametresState extends State<Parametres> {
  late bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
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

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    BoxDecoration? backgroundDecoration;
    if (!_isDarkMode) {
      backgroundDecoration = AppDesign.buildBackgroundDecoration();
    }

    return Scaffold(
      body: Container(
        decoration: backgroundDecoration,
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    _isDarkMode
                        ? 'images/whiteparametres.png'
                        : 'images/blackparametres.png',
                    width: (screenSize.width / 5),
                    height: (screenSize.height / 5),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Paramètres',
                  style: TextStyle(
                    fontSize: screenSize.width / 8,
                    color: _isDarkMode ? Colors.white : Colors.black,
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                // Naviguer vers UserProfile
                Navigator.push(
                  context,
                  MaterialPageRoute(
                   builder: (context) => const PDigicodePage(title: "Accueil",
                   ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    _isDarkMode ? 'images/whiteprofil.png' : 'images/blackprofil.png',
                    width: (screenSize.width / 10),
                    height: (screenSize.height / 10),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    "Mon profil",
                    style: TextStyle(
                      fontSize: screenSize.width / 16,
                      color: _isDarkMode ? Colors.white : Colors.black,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Themes(title: "theme")),
                );
              },
              child: Row(
                children: <Widget>[
                  Image.asset(
                    _isDarkMode ? 'images/whitepersonnalisation.png' : 'images/blackpersonnalisation.png',
                    width: (screenSize.width / 10),
                    height: (screenSize.height / 10),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    "Thèmes",
                    style: TextStyle(
                      fontSize: screenSize.width / 16,
                      color: _isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  _isDarkMode ? 'images/whitenotif.png' : 'images/blacknotif.png',
                  width: (screenSize.width / 10),
                  height: (screenSize.height / 10),
                ),
                const SizedBox(
                  width: 50,
                ),
                Text(
                  "Notifications et rappels",
                  style: TextStyle(
                    fontSize: screenSize.width / 16,
                    color: _isDarkMode ? Colors.white : Colors.black,
                  ),
                )
              ],
            )
          ),
        ),
      );
    );
  }
}

