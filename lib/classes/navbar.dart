import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/parametres.dart';
import 'chargement.dart';
import 'calendrier.dart';
import 'accueil.dart';
import 'notes.dart';
import 'dossiers.dart';

const Color bottomNavBgColor = Color.fromARGB(192, 129, 61, 212);

class NavBar extends StatefulWidget {
  const NavBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> _pages = <Widget>[
      Accueil(title: "notes"),
      Calendar(title: "calendar"),
      Chargement(title: 'yousk2'),
      Icon(
        Icons.note_add,
        size: 150,
      ),
      Calendar(title: "calendar",),
      Parametres(title: 'settings'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(27)),
          color: bottomNavBgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedIconTheme:
              IconThemeData(size: 32), // Agrandir l'icône sélectionnée
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.house),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'calendrier',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.add_circle_outline), // Icône "Ajouter" pour les notes
              label: 'Notes', // Label pour les notes
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons
                  .history), // Icône de vue liste pour le résumé ou le récapitulatif
              label: 'Récapitulatif ', // Label pour le résumé
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Paramètres',
            ),
          ],
        ),
      ),
    );
  }
}
