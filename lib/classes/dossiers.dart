import 'package:flutter/material.dart';

class DossiersPage extends StatefulWidget {
  @override
  _DossiersPageState createState() => _DossiersPageState();
}

class _DossiersPageState extends State<DossiersPage> {
  List<String> dossiers = ['Dossier Favoris']; // Liste des dossiers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dossiers'),
      ),
      body: ListView.builder(
        itemCount: dossiers.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(dossiers[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _ajouterDossier(); // Appeler la fonction pour ajouter un nouveau dossier
        },
        tooltip: 'Ajouter un dossier',
        child: Icon(Icons.add),
      ),
    );
  }

  // Fonction pour ajouter un nouveau dossier
  void _ajouterDossier() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: Text('Ajouter un dossier'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Nom du dossier'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  String nouveauDossier = controller.text.trim();
                  if (nouveauDossier.isNotEmpty) {
                    dossiers.add(nouveauDossier);
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }
}