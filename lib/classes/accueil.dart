import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Accueil extends StatefulWidget {
  const Accueil({super.key, required this.title});

  final String title;

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Column(children: <Widget>[
                Text('test')
              ]),
            )));
  }
}