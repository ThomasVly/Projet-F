import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Themes extends StatefulWidget {
  const Themes({Key? key, required this.title});

  final String title;

  @override
  State<Themes> createState() => _ThemesState();
}

class _ThemesState extends State<Themes> {
  double _sliderValue = 0.0;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _sliderValue = _prefs.getDouble('theme') ?? 0.0;
    });
  }

  Future<void> _savePreferences(double value) async {
    setState(() {
      _sliderValue = value;
    });
    await _prefs.setDouble('theme', value);
    bool isDarkMode = value ==1.0;
    MyApp.updateTheme(context, isDarkMode);

  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return AnimatedTheme(
      data: _sliderValue == 0 ? ThemeData.light() : ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Thèmes"),
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                _sliderValue == 0 ? "Mode clair" : "Mode sombre",
                style: TextStyle(fontSize: screenSize.width / 16),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    _sliderValue == 0
                        ? 'images/blacksun.png'
                        : 'images/whitesun.png',
                    width: 50,
                    height: 50,
                  ),
                  Expanded(
                    child: Slider(
                      value: _sliderValue,
                      onChanged: (value) async {
                        await _savePreferences(value);
                      },
                      min: 0,
                      max: 1,
                      divisions: 1,
                      label: _sliderValue == 0 ? 'Clair' : 'Sombre',
                    ),
                  ),
                  Image.asset(
                    _sliderValue == 0
                        ? 'images/blackmoon.png'
                        : 'images/whitemoon.png',
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
