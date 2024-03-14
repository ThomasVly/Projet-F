import 'package:flutter/material.dart';
import 'accueil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendrier.dart';
import 'notes.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


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

      Notes(title: "notes",),
      Calendar(title: "calendar",),
      AccueilPage(title: 'yousk2'),
    ];

    return Scaffold(

      appBar: AppBar(
        title: const Text(''),
      ),
      
      body : Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar:BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
        ],
        currentIndex : _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}