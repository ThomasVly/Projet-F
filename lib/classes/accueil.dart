import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/dossiers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'themes.dart';
import 'RecherchePage.dart';
import 'design.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key, required this.title});

  final String title;

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  late bool _isDarkMode = false;
  late SharedPreferences _prefs;
  late DateTime selectedDate;
  late ScrollController _scrollController;
  late String note = "";
  var temp = [];
  String textToPrint = "";
  String emotion = "";
  


  final List<Map<String, dynamic>> _emotions = [
    {'name': 'Joie', 'emoji': '😊'},
    {'name': 'Tristesse', 'emoji': '😢'},
    {'name': 'Colère', 'emoji': '😡'},
    {'name': 'Amour', 'emoji': '😍'},
    {'name': 'Choc', 'emoji': '😱'},
    {'name': 'Peur', 'emoji': '😖'},
  ];

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
    String dateString =DateFormat('dd/MM/yyyy').format(selectedDate);

    String? value = prefs.getString(dateString);
    if (value != null) {
      setState(() {
        note = value;
        textToPrint = note.split("<>")[0];

        if (note.split("<>")[3]=="Joie"){emotion = '😊';}
        if (note.split("<>")[3]=="Tristesse"){emotion = '😢';}
        if (note.split("<>")[3]=="Colère"){emotion = '😡';}
        if (note.split("<>")[3]=="Amour"){emotion = '😍';}
        if (note.split("<>")[3]=="Choc"){emotion = '😱';}
        if (note.split("<>")[3]=="Peur"){emotion = '😖';}
      });
    }
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

    List<String> moisEnFrancais = [
      "Janvier",
      "Février",
      "Mars",
      "Avril",
      "Mai",
      "Juin",
      "Juillet",
      "Août",
      "Septembre",
      "Octobre",
      "Novembre",
      "Décembre"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mon journal",
          style: AppDesign.titleStyle,
        ),
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
      body: Container(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              '${moisEnFrancais[now.month - 1]} ${now.year}',
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
                                textToPrint ="Il n'y a pas de notes pour le ${DateFormat('dd/MM/yyyy').format(selectedDate.add(Duration(days: 1)))}";
                                note="";
                                emotion = "";
                                retrieveStringValue();
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
              child: Container(
                  padding: EdgeInsets.all(8.0), // Adjust padding as needed
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Change color as needed
                    border: Border.all(color: Colors.black), // Change color as needed
                    borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
                  ),
                  child: ListTile(
                      leading: Text(
                        emotion,
                        style: TextStyle(fontSize: 40),
                      ),
                      subtitle: Text(
                        "${DateFormat('dd/MM/yyyy').format(selectedDate)} : $textToPrint",
                        style: TextStyle(fontSize: 40),
                      )
                  )
              ),
            )

          ],
        ),
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
