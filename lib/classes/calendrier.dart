import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'event.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'notes.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key, required this.title});

  final String title;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List<Note>> notes = {};

  late final ValueNotifier<List<Note>> _selectedNotes;

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
    _selectedDay = _focusedDay;
    _selectedNotes = ValueNotifier(_getNotesForDay(_selectedDay!));
    retrieveNotesList();
    initializeDateFormatting();
  }

  void retrieveNotesList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("21/03/2024",
        "titre<>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum<>#joyeux#vie<>Joie<><>true");
    await prefs.setString("28/03/2024",
        "titre<>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum<>#joyeux#vie<>Joie<><>false");
    await prefs.setString("01/03/2024",
        "drôle<>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum<>#joyeux<>Joie<><>false");
    await prefs.setString("02/03/2024",
        "titre<>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum<>#joyeux#vie<>Joie<><>false");
    notes.clear(); // Effacer les données précédentes de la carte

    // Définir l'intervalle de dates (du 1er janvier 2020 au 1er janvier 2025)
    DateTime startDate = DateTime(2020, 1, 1);
    DateTime endDate = DateTime(2025, 1, 1);

    // Parcourir toutes les dates dans l'intervalle
    for (DateTime date_i = startDate;
        date_i.isBefore(endDate);
        date_i = date_i.add(const Duration(days: 1))) {
      String? noteValue =
          prefs.getString(DateFormat('dd/MM/yyyy').format(date_i));
      if (noteValue != null) {
        // Diviser la valeur en différentes parties
        List<String> noteParts = noteValue.split("<>");

        // Extraire les tags de la partie des tags
        List<String> tags = [];
        for (String part in noteParts[2].split('#')) {
          if (part.isNotEmpty) {
            tags.add('#' + part.trim()); // Ajouter le '#' manquant
          }
        }
        // Créer un objet Note à partir des parties divisées
        Note note = Note(
          noteParts[0], // title
          noteParts[1], // text
          noteParts[3], // emotion
          date_i.toUtc().add(const Duration(hours: 1)),
          tags: tags
        );
        // Ajouter la note à la liste des notes pour cette date
        if (notes.containsKey(date_i)) {
          notes[date_i.toUtc().add(const Duration(hours: 1))]!.add(note);
        } else {
          notes[date_i.toUtc().add(const Duration(hours: 1))] = [note];
        }
      }
    }
    // Une fois toutes les notes récupérées, mettre à jour l'affichage si nécessaire
    setState(() {});
  }

  List<Note> _getNotesForDay(DateTime day) {
    return notes[day] ?? [];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calendrier'),
        ),
        body: Column(children: [
          TableCalendar(
            calendarBuilders:
                CalendarBuilders(defaultBuilder: (context, date, _) {
              if (notes.containsKey(date)) {
                return Container(
                  margin: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 139, 89, 213),
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        Text(
                          '${date.day}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return null;
            }),
            firstDay: DateTime(2020, 1, 1),
            lastDay: DateTime(2025, 1, 1),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            eventLoader: _getNotesForDay,
            locale: 'fr_FR',
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _selectedNotes.value = _getNotesForDay(selectedDay);
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
          ),

          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _selectedNotes,
              builder: (context, value, _) {
                if (value.isEmpty) {
                  return const Center(
                    child: Text(
                      "Tu n'as pas écrit de note pour cette date",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      final Note note = value[index];
                      final DateTime dateNote = note.date;
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          onTap: () => 
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => Notes(title:"yousk2", selectedDate: note.date)
                            ),
                          ), 
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Titre de la note
                              Text(
                                note.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8), // Espacement entre le titre et la date

                              // Date de la note
                              Text(
                                DateFormat.yMMMd('fr_FR').format(note.date),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),

                              const SizedBox(height: 8), // Espacement entre la date et les tags

                              // Tags de la note
                              Wrap(
                                spacing: 4,
                                runSpacing: 4,
                                children: note.tags.map((tag) => Chip(label: Text(tag))).toList(),
                              ),
                            ],
                          ),
                          // Emoji correspondant à l'humeur de la note
                          leading: SizedBox(
                            child: _getEmotionEmoji(dateNote),
                          ),
                          // Texte de la note
                          subtitle: Text(
                            note.text,
                            maxLines: 2, // Limite le texte à 2 lignes pour un aperçu
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ]
      )
    );
  }

  Widget _getEmotionEmoji(DateTime date) {
    List<Note> notesForDate = _getNotesForDay(date);
    if (notesForDate.isNotEmpty) {
      String emotion = notesForDate.first.emotion;
      Map<String, dynamic>? emotionData = _emotions.firstWhere(
        (element) => element['name'] == emotion,
        orElse: () => {},
      );
      if (emotionData != {}) {
        return Text(
          emotionData['emoji'],
          style: const TextStyle(fontSize: 20),
        );
      }
    }
    return const SizedBox
        .shrink(); // Retourne un widget vide si aucune émotion n'est trouvée
  }
}
