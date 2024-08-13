import 'package:flutter/material.dart';

/// class to display score for quiz_me
///
/// properties:
/// - icon: takes IconData to display desired icon on screen
/// - color: sets the Icon color
/// - score: sets the score to be displayed
class QuizScoreCard extends StatelessWidget {
  final IconData icon;
  final ColorSwatch color;
  final int score;

  const QuizScoreCard(
      {required this.icon,
      required this.color,
      required this.score,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 40),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("$score",
                style: const TextStyle(fontSize: 30, color: Colors.white)),
          )
        ],
      ),
    );
  }
}
