import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/dossiers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'RecherchePage.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key, required this.title});

  final String title;

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  late SharedPreferences _prefs;
  late DateTime selectedDate;
  late ScrollController _scrollController;
  late String note = "";
  var temp = [];

  @override
  void initState() {
    super.initState();
    retrieveStringValue();
    _initPreferences();
    selectedDate = DateTime.now();
    _scrollController = ScrollController();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Centrer automatiquement la bulle sélectionnée
      _scrollToSelectedDate();
    });

  }

  retrieveStringValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("21/01/24", "titre<>text<>#joyeux<>Happy");
    String? value = prefs.getString("21/01/24");
    if (value != null) {
      setState(() {
        note = value;
      });
    }
    temp = note.split("<>");
    print(temp);
  }

  void _scrollToSelectedDate() {
    final screenWidth = MediaQuery.of(context).size.width;
    final selectedDateIndex = selectedDate.day - 1;
    final scrollOffset = (selectedDateIndex * 78.0) - (screenWidth / 2 - 60);
    _scrollController.animateTo(
      scrollOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // Fonction pour initialiser les préférences partagées
  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    int numberOfDaysInMonth = DateTime(now.year, now.month + 1, 0).day;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(
                    255, 189, 208, 218), // Arrière-plan bleu-gris
                shape: BoxShape.circle,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search,
                  color: Colors.purpleAccent,
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecherchePage()),
              );
              // Code à exécuter lorsqu'on appuie sur l'icône de recherche
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.folder,
              color: Color.fromARGB(
                  255, 115, 81, 170), // Couleur bleue pour l'icône de dossier
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DossiersPage()),
              );
              // Code à exécuter lorsqu'on appuie sur l'icône de dossier
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            DateFormat('MMMM yyyy').format(now),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Spacer(
                  flex:
                      1), // Espace vide équivalent à la moitié de la largeur de l'écran
              Expanded(
                flex: numberOfDaysInMonth,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  // Aligner la ligne d'éléments horizontalement au milieu
                  child: Row(
                    children: [
                      for (int i = 0; i < numberOfDaysInMonth; i++)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDate =
                                  firstDayOfMonth.add(Duration(days: i));
                            });
                          },
                          child: Container(
                            width: selectedDate != null &&
                                    selectedDate.day == i + 1
                                ? 100
                                : 70,
                            height: selectedDate != null &&
                                    selectedDate.day == i + 1
                                ? 100
                                : 70,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedDate != null &&
                                      selectedDate.day == i + 1
                                  ? const Color.fromARGB(255, 139, 89, 213)
                                  : Colors.grey,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  '${i + 1}',
                                  style: TextStyle(
                                    color: selectedDate != null &&
                                            selectedDate.day == i + 1
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: selectedDate != null &&
                                            selectedDate.day == i + 1
                                        ? 18
                                        : 16,
                                  ),
                                ),
                                if (selectedDate != null &&
                                    selectedDate.day == i + 1 &&
                                    selectedDate == now)
                                  Positioned(
                                    bottom:
                                        -20, // Ajustez cette valeur selon votre préférence
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const Spacer(
                  flex:
                      1), // Espace vide équivalent à la moitié de la largeur de l'écran
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Il n'y a pas de notes pour le ${DateFormat('dd/MM/yyyy').format(selectedDate)},\ntitre:${temp[0]}\ntexte:${temp[1]}\ntag:${temp[2]}\nemotion:${temp[3]}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Journal Intime',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Accueil(title: 'Mon Journal Intime'),
    );
  }
}
