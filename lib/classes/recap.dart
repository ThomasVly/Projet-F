import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Recap extends StatefulWidget {
  const Recap({super.key, required this.title});

  final String title;

  @override
  State<Recap> createState() => _RecapState();
}

class _RecapState extends State<Recap> {
  late TextEditingController _controller;
  late DateTime now;
  late String utilisable ;
  List<String> temp = [];

  Map<String, double> dataMap = {
    '😊' : 0,
    '😢' : 0,
    '😡' : 0,
    '😍' : 0,
    '😱' : 0,
    '😖' : 0
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

    for (var i =0; i<7; i++) {
      String? value = prefs.getString(DateFormat('dd/MM/yyyy').format(now.subtract(Duration(days: i))));
      if (value != null) {
        setState(() {
          if (value.split("<>")[3] == 'Joie'){dataMap['😊'] = (dataMap['😊'] ?? 0) + 1;}
          if (value.split("<>")[3] == 'Tristesse'){dataMap['😢'] = (dataMap['😢'] ?? 0) + 1;}
          if (value.split("<>")[3] == 'Colère'){dataMap['😡'] = (dataMap['😡'] ?? 0) + 1;}
          if (value.split("<>")[3] == 'Amour'){dataMap['😍'] = (dataMap['😍'] ?? 0) + 1;}
          if (value.split("<>")[3] == 'Choc'){dataMap['😱'] = (dataMap['😱'] ?? 0) + 1;}
          if (value.split("<>")[3] == 'Peur'){dataMap['😖'] = (dataMap['😖'] ?? 0) + 1;}
        });
      }
    }
  }

  int countOccurrences<T>(List<T> list, T element) {
    return list.where((item) => item == element).length;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Le récapitulatif est à partir du ${DateFormat.yMd().format(now)}"),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8, // Adjust the width as per your requirement
              height: MediaQuery.of(context).size.width * 0.8, // Adjust the height as per your requirement
              child: PieChart(dataMap: dataMap),
            ),
          ],
        ),
      ),
    );
  }
}