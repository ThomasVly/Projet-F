import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        actions: [
          ElevatedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
            ),
            onPressed: () {
              // Action à effectuer lorsque le bouton est pressé
            },
            child: Text("coucou")
          )
        ],
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
      ),
      body: Align(
        
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Lot de tuyaux galvanisés:',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'images/galvanized-steel-tubes.webp',
                  width: 200,
                  height: 200,
                ),
                const Text(
                  'Prix : 40 €'
                )
                // Vous pouvez ajouter d'autres éléments de la ligne ici si nécessaire
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Description : ',
                ),
              ]
            ),
            const SizedBox(
              height: 50,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Lot de 20 tuyaux galvanisés de très bonne qualité',
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