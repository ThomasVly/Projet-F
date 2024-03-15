import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  const Notes({super.key, required this.title});

  final String title;

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
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
            child: Center(
              child: Column(children: <Widget>[
                TextField(
                  controller: _controller,
                  onSubmitted: (String value) {
                    debugPrint(value);
                  },
                ),
                ElevatedButton(
                  child: const Text('Terminer la Note'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(_controller.text)));
                  },
                ),
              ]),
            )));
  }
}