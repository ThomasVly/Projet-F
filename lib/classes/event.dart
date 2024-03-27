class Note {
  final String title;
  final String text;
  List<String> tags; // Retirez l'initialisation ici

  final String emotion;
  final DateTime date;

  // Ajoutez les tags entre {} pour les rendre optionnels avec une valeur par défaut
  Note(this.title, this.text, this.emotion, this.date, {List<String>? tags})
      : tags = tags ?? []; // Utilisez ?? pour fournir une valeur par défaut (une liste vide)
}
