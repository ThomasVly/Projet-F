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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 100), // Ajustez l'espace au-dessus du titre
                Container(
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    _isDarkMode
                        ? 'images/whiteparametres.png'
                        : 'images/blackparametres.png',
                    width: (MediaQuery.of(context).size.width / 5.5),
                    height: (MediaQuery.of(context).size.height / 5.5),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Paramètres',
                  style: TextStyle(
                    fontSize: 28, // Taille de police inchangée
                    color: _isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 40),
                buildClickableRow(
                  icon: _isDarkMode
                      ? 'images/whiteprofil.png'
                      : 'images/blackprofil.png',
                  label: 'Mon profil',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const PDigicodePage(title: "Accueil"),
                      ),
                    );
                  },
                ),
                buildClickableRow(
                  icon: _isDarkMode
                      ? 'images/whitepersonnalisation.png'
                      : 'images/blackpersonnalisation.png',
                  label: 'Thèmes',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Themes(title: "theme")),
                    );
                  },
                ),
                buildClickableRow(
                  icon: _isDarkMode
                      ? 'images/whitenotif.png'
                      : 'images/blacknotif.png',
                  label: 'Notifications et rappels',
                  onTap: () {
                    // Add your logic for notifications and reminders here
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildClickableRow(
      {required String icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(
                  icon,
                  width: 40, // Taille de l'icône inchangée
                  height: 40, // Taille de l'icône inchangée
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 18, // Taille de police inchangée
                    color: _isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Color.fromARGB(255, 168, 0, 146),
            ),
          ],
        ),
      ),
    );
  }
}
