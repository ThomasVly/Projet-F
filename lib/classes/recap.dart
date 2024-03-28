import 'package:flutter/material.dart';
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
      String? value = prefs.getString(DateFormat('dd/MM/yyyy').format(now.subtract(Duration(days: i))));
      if (value != null) {
        setState(() {
          if (value.split("<>")[3] == 'Joie') {
            dataMap['😊'] = (dataMap['😊'] ?? 0) + 1;
          }
          if (value.split("<>")[3] == 'Tristesse') {
            dataMap['😢'] = (dataMap['😢'] ?? 0) + 1;
          }
          if (value.split("<>")[3] == 'Colère') {
            dataMap['😡'] = (dataMap['😡'] ?? 0) + 1;
          }
          if (value.split("<>")[3] == 'Amour') {
            dataMap['😍'] = (dataMap['😍'] ?? 0) + 1;
          }
          if (value.split("<>")[3] == 'Choc') {
            dataMap['😱'] = (dataMap['😱'] ?? 0) + 1;
          }
          if (value.split("<>")[3] == 'Peur') {
            dataMap['😖'] = (dataMap['😖'] ?? 0) + 1;
          }
        });
      }
    }
  }

  int countOccurrences<T>(List<T> list, T element) {
    return list.where((item) => item == element).length;
  }

  void change_day() {
    dataMap.clear();
    retrieveStringValue();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Recapitulatif",
          style: AppDesign.titleStyle,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: [
                    PieChart(
                      dataMap: dataMap,
                      legendOptions: LegendOptions(
                        legendPosition: LegendPosition.bottom,
                        legendTextStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 20), // Ajustez cet espacement selon votre besoin
                        
                      ),
                    ),
                  ],
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
              Text("Le récapitulatif comprends les ${jour.toInt()} derniers jours"),
            ],
          ),
        ),
      ),
    );
  }
}
