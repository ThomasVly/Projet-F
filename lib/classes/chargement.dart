import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/digicode.dart';
import 'package:flutter_application_1/classes/inscriptionPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chargement extends StatefulWidget{
  const Chargement({super.key, required this.title});


  final String title;

  @override
  State<Chargement> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<Chargement>{

  late String username = "";

  @override
  void initState() {
    super.initState();
    retrieveStringValue();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>InscriptionPage(), 
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                /*const SizedBox(
                  width:50,
                ),*/
                Image.asset(
                  
                  'images/logo.png',
                  width : (screenSize.width/2),
                  height: (screenSize.height/2),
                ),
                
                // Vous pouvez ajouter d'autres éléments de la ligne ici si nécessaire
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*SizedBox(
                  height:50,
                ),*/
                Text(
                  "Bienvenue $username",
                  style : TextStyle(fontSize: screenSize.width/16)
                )
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/gif-diary.gif',
                  width : (screenSize.width/4),
                  height: (screenSize.height/4),
                ),
              ]
            )
          ],
        ),
       
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}