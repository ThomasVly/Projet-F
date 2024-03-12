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
  Widget build(BuildContext context){
     return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                
                const SizedBox(
                  width:50,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:MaterialStateProperty.all<Color>(Colors.black),
                    backgroundColor:MaterialStateProperty.all<Color>(Colors.blueGrey),
                  ),
                  onPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Accueil')),
                    );
                  },
                  child: const Text('Connexion'),
                ),
                // Vous pouvez ajouter d'autres éléments de la ligne ici si nécessaire
              ],
            ),
            
          ],
        ),
       
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}