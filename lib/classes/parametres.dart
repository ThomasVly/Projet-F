import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Parametres extends StatefulWidget{
  const Parametres({super.key, required this.title});


  final String title;

  @override
  State<Parametres> createState() => _ParametresState();

}

class _ParametresState extends State<Parametres>{
  late bool _isDarkMode =false;
  
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
  Widget build(BuildContext context){
    Size screenSize = MediaQuery.of(context).size;
     return Scaffold(
      body: Align(
        
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          /*const Row(
               mainAxisAlignment: MainAxisAlignment.center,    // Titre de haut de page
               children: <Widget>[
              Text(
                'Journal Intime',
              ),
               ]
            ),*/
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                
                /*const SizedBox(
                  width:50,
                ),*/
                Image.asset(  
                  _isDarkMode
                  ?'images/whiteparametres.png'
                  :'images/blackparametres.png',
                  width : (screenSize.width/8),
                  height: (screenSize.height/8),
                ),
                Text(
                  'Paramètres',
                  style : TextStyle(fontSize: screenSize.width/8),
                )
                
                // Vous pouvez ajouter d'autres éléments de la ligne ici si nécessaire
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height:50,
                ),
                Image.asset(
                  _isDarkMode
                  ? 'images/whiteprofil.png' :
                  'images/blackprofil.png',
                  width : (screenSize.width/16),
                  height: (screenSize.height/16),
                ),
                const SizedBox(
                  width:50,
                ),
                Text(
                  "Mon profil",
                  style : TextStyle(fontSize: screenSize.width/16)
                )
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    // Action à exécuter lors du clic sur le bouton "Thèmes"
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Themes(title: "theme")),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        _isDarkMode?
                        'images/whitepersonnalisation.png':
                        'images/blackpersonnalisation.png',
                        width: (screenSize.width / 16),
                        height: (screenSize.height / 16),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        "Thèmes",
                        style: TextStyle(fontSize: screenSize.width / 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  _isDarkMode?
                  'images/whitenotif.png':
                  'images/blacknotif.png',
                  width : (screenSize.width/16),
                  height: (screenSize.height/16),
                ),
                const SizedBox(
                  width:50,
                ),
                Text(
                  "Notifications et rappels",
                  style : TextStyle(fontSize: screenSize.width/16)
                )
                
              ]
            )
            
          ],
        ),
       
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}