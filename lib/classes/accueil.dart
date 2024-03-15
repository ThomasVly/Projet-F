import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Accueil extends StatefulWidget {
  const Accueil({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  late String username = "";

  @override
  void initState() {
    super.initState();
    retrieveStringValue();
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
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Username: $username"),
            ],
          ),
        ),
      ),
    );
  }
}
