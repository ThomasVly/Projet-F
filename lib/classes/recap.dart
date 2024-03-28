import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/design.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'design.dart';

class Recap extends StatefulWidget {
  const Recap({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Recap> createState() => _RecapState();
}

class _RecapState extends State<Recap> {
  late TextEditingController _controller;
  late DateTime now;
  late String utilisable;
  List<String> temp = [];
  double jour = 7;
  var text = "hebdomadaire";
  List<int> max = [0, 0, 0, 0, 0, 0];
  List<String> Joie = ["La joie te va bien!"];
  List<String> Tristesse = [
    "Tu es capable d'accomplir de grandes choses, la tristesse est un passage"
  ];
  List<String> Colere = ["Je suis un homme en colère"];
  List<String> Amour = ["L'amour est temporaire, flutter est eternel"];
  List<String> Choc = ["Des céréales CHOCapic?"];
  List<String> Peur = ["Jouez a Subnautica, courage pour l'avenir"];

  Map<String, double> dataMap = {
    '😊': 0,
    '😢': 0,
    '😡': 0,
    '😍': 0,
    '😱': 0,
    '😖': 0
  };

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    now = DateTime.now();
    retrieveStringValue();
  }

  retrieveStringValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (var i = 0; i < jour; i++) {
      String? value = prefs.getString(
          DateFormat('dd/MM/yyyy').format(now.subtract(Duration(days: i))));
      if (value != null) {
        setState(() {
          if (value.split("<>")[3] == 'Joie') {
            dataMap['😊'] = (dataMap['😊'] ?? 0) + 1;
            max[0] += 1;
          }
          if (value.split("<>")[3] == 'Tristesse') {
            dataMap['😢'] = (dataMap['😢'] ?? 0) + 1;
            max[1] += 1;
          }
          if (value.split("<>")[3] == 'Colère') {
            dataMap['😡'] = (dataMap['😡'] ?? 0) + 1;
            max[2] += 1;
          }
          if (value.split("<>")[3] == 'Amour') {
            dataMap['😍'] = (dataMap['😍'] ?? 0) + 1;
            max[3] += 1;
          }
          if (value.split("<>")[3] == 'Choc') {
            dataMap['😱'] = (dataMap['😱'] ?? 0) + 1;
            max[4] += 1;
          }
          if (value.split("<>")[3] == 'Peur') {
            dataMap['😖'] = (dataMap['😖'] ?? 0) + 1;
            max[5] += 1;
          }
        });
      }
    }
  }

  String convivialite() {
    int maxi = 0;
    int indi = 0;
    String retour = "";

    for (int i = 0; i < max.length; i++) {
      if (max[i] > maxi) {
        maxi = max[i];
        indi = i;
      }
    }

    if (indi == 0) {
      retour = Joie[Random().nextInt(Joie.length)];
    }
    if (indi == 1) {
      retour = Tristesse[Random().nextInt(Tristesse.length)];
    }
    if (indi == 2) {
      retour = Colere[Random().nextInt(Colere.length)];
    }
    if (indi == 3) {
      retour = Amour[Random().nextInt(Amour.length)];
    }
    if (indi == 4) {
      retour = Choc[Random().nextInt(Choc.length)];
    }
    if (indi == 5) {
      retour = Peur[Random().nextInt(Peur.length)];
    }

    return retour;
  }

  int countOccurrences<T>(List<T> list, T element) {
    return list.where((item) => item == element).length;
  }

  void change_day() {
    dataMap.clear();
    max = [0, 0, 0, 0, 0, 0];
    retrieveStringValue();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Votre Récapitulatif',
            style: AppDesign.titleStyle,
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Le récapitulatif est à partir du ${DateFormat.yMd().format(now)}, il est $text",
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.8, // Adjust the width as per your requirement
                    height: MediaQuery.of(context).size.width *
                        0.8, // Adjust the height as per your requirement
                    child: PieChart(
                      dataMap: dataMap,
                      legendOptions: LegendOptions(
                        legendTextStyle: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Slider(
                    min: 7.0,
                    max: 50.0,
                    value: jour,
                    onChanged: (value) {
                      setState(() {
                        jour = value;
                        change_day();
                      });
                    },
                  ),
                  Text(
                    "Le récapitulatif comprends les ${jour.toInt()} derniers jours\n",
                  ),
                  Text(
                    convivialite(),
                    style: TextStyle(
                      color: Color.fromARGB(
                          255, 250, 141, 244), // Couleur du texte d'humeur
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
