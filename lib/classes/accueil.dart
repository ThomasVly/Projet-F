import 'package:flutter/material.dart';
import 'myHomePage.dart';

class AccueilPage extends StatefulWidget{
  const AccueilPage({super.key, required this.title});


  final String title;

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage>{
  @override
  void initState() {
    super.initState();

    // Utilisez Future.delayed pour attendre 2 secondes avant de naviguer vers une autre page
    Future.delayed(Duration(seconds: 3), () {
      // Utilisez Navigator pour naviguer vers une autre page (par exemple, la page suivante)
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>const MyHomePage(title:"accueil"), // Remplacez AutrePage par le nom de votre page suivante
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
          Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
              const Text(
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