import 'package:flutter/material.dart';
import 'navbar.dart';

class Chargement extends StatefulWidget{
  const Chargement({super.key, required this.title});


  final String title;

  @override
  State<Chargement> createState() => _ChargementState();
}

class _ChargementState extends State<Chargement>{
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>const MyHomePage(title:"accueil"),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context){
     return Scaffold(
      body: Align(
        
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          const Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                  Text(
                    'Journal Intime',
              ),
               ]
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                const SizedBox(
                  width:50,
                ),
                Image.asset(
                  'images/logo.png',
                  width: 200,
                  height: 200,
                ),
                
                // Vous pouvez ajouter d'autres éléments de la ligne ici si nécessaire
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height:200,
                ),
                Text(
                  "Bienvenue jeune padawan",
                )
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/gif-diary.gif',
                  width: 200,
                  height: 200,
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