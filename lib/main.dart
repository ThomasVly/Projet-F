import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/chargement.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void updateTheme(BuildContext context, bool isDarkMode) {
    final state = context.findAncestorStateOfType<_MyAppState>();
    state?.updateTheme(isDarkMode);
  }
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences _prefs;
  late bool _isDarkMode=false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = _prefs.getDouble('theme') == 1.0;
    });
  }

  void updateTheme(bool isDarkMode) async {
    setState(() {
      _isDarkMode = isDarkMode;
    });
    await _prefs.setDouble('theme', isDarkMode ? 1.0 : 0.0);
  }

  bool isDarkMode() {
    return _isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Produit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Ajoutez votre configuration de thème ici si nécessaire
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        sliderTheme: SliderThemeData(
          thumbShape: const RoundSliderThumbShape(
            enabledThumbRadius: 16,
          ),
          overlayShape: const RoundSliderOverlayShape(
            overlayRadius: 24,
          ),
          trackHeight: 36,
        ),
      ),
      home: const Chargement(title: "Page de connexion"),
      builder: (context, child) {
        return AnimatedTheme(
          data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
          child: child!,
        );
      },
    );
  }
}
