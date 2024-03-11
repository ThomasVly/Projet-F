import 'package:flutter/material.dart';
import 'classes/myHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Produit',
      debugShowCheckedModeBanner:false, 
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AccueilPage(title: "Page de connexion"),
    );
  }
}


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
                Image.asset(
                  'images/galvanized-steel-tubes.webp',
                  width: 150,
                  height: 150,
                ),
                const Text(
                  'Prix : 40 €'
                ),
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
                      MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Produit')),
                    );
                  },
                  child: const Text('Voir le produit'),
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

/*class AssetsImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asset Image'),
      ),
      body: Container(
        color: Colors.white,
        child: Image.asset(
          'images/cover.png',
         
        ),
      ),
    );
  }
}*/