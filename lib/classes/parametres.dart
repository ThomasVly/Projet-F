import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/themes.dart';
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
                    fontSize: screenSize.width / 10,
                    color: _isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 30),
                buildParametreItem(
                  iconPath: _isDarkMode
                      ? 'images/whiteprofil.png'
                      : 'images/blackprofil.png',
                  text: 'Mon profil',
                  onTap: () {
                    // Action à exécuter lors du clic sur "Mon profil"
                  },
                ),
                buildParametreItem(
                  iconPath: _isDarkMode
                      ? 'images/whitepersonnalisation.png'
                      : 'images/blackpersonnalisation.png',
                  text: 'Thèmes',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Themes(title: "theme")),
                    );
                  },
                ),
                buildParametreItem(
                  iconPath: _isDarkMode
                      ? 'images/whitenotif.png'
                      : 'images/blacknotif.png',
                  text: 'Notifications et rappels',
                  onTap: () {
                    // Action à exécuter lors du clic sur "Notifications et rappels"
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildParametreItem(
      {required String iconPath,
      required String text,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: <Widget>[
            Image.asset(
              iconPath,
              width: 32,
              height: 32,
            ),
            SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(fontSize: 20),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Color.fromARGB(255, 143, 0, 100),
            ),
          ],
        ),
      ),
    );
  }
}
