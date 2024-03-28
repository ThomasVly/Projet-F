import 'package:flutter/material.dart';

class AppDesign {
  static BoxDecoration buildBackgroundDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(207, 184, 120, 168),
          Color.fromARGB(255, 255, 255, 255),
        ],
      ),
    );
  }

  // Palette de couleurs
  static const Color primaryColor = Color.fromARGB(255, 198, 89, 231);
  static const Color secondaryColor = Color.fromARGB(255, 173, 147, 219);

  // Personnalisation de la police et typographie
  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color.fromARGB(255, 26, 1, 41),
  );

  // Spécifiez les tailles et les marges recommandées pour l'alignement des icônes dans l'interface utilisateur
  static const double iconSize = 32.0;
  static const EdgeInsets iconMargin = EdgeInsets.all(8.0);

  // Si votre application utilise des illustrations ou des graphiques, définissez un style visuel cohérent pour ceux-ci.
  // Cela peut inclure des directives sur le style artistique, les palettes de couleurs et les techniques de représentation.
  // Exemple :
  static const Color illustrationColor = Color.fromARGB(255, 82, 0, 82);
}
