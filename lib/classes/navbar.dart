import 'package:flutter/material.dart';
import 'chargement.dart';
import 'calendrier.dart';
import 'accueil.dart';
import 'notes.dart';



class NavBar extends StatefulWidget {
  const NavBar({super.key, required this.title});


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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.


    const List<Widget> _pages = <Widget>[

      Accueil(title: "notes",),
      Calendar(title: "calendar",),
      Chargement(title: 'yousk2'),
      Icon(
        Icons.calendar_today,
        size: 150,
      ),
      Notes(title: "notes",)
    ];

    return Scaffold(

      appBar: AppBar(
        title: const Text(''),
      ),
      
      body : Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fast_rewind),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
        ],
        currentIndex : _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}