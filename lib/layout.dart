import 'package:flutter/material.dart';
import 'package:quiz_me/components/score_keeper.dart';
import 'package:quiz_me/components/ui/quiz_button.dart';
import 'package:quiz_me/components/ui/score_card.dart';

/// This class sets up layout of our app including
/// - Score card
/// - Question Or Restart button at the end of the quiz
/// - Answer buttons
///
/// Score Card: it make use of QuizButton and, QuizScoreCard components
/// to build Scorecard UI and, ScoreKeeper instance to fetch current scores
///
/// Question or Restart: This is part of Layout itself and, replaced by the
/// Restart button at the end of quiz
///
/// Answers: it makes used of QuizButton to create expandable True and False
/// button, they are used to register the user answer
///
///
/// Properties:
/// - question: current question to be displayed
/// - onAnswer: callback function to use when user submit the answer
/// - isGameOver: current status of the game, is false when we are done with
/// all the questions
/// - scoreKeeper: instance of ScoreKeeper class that manges and provides
/// current score
/// - onRestart: callback function use when user submits "Restart" request
class Layout extends StatelessWidget {
  final String question;
  final Function(bool) onAnswer;
  final bool isGameOver;
  final ScoreKeeper scoreKeeper;
  final VoidCallback onRestart;

  const Layout(
      {required this.question,
      required this.onAnswer,
      required this.isGameOver,
      required this.scoreKeeper,
      required this.onRestart,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          _buildScoreCard(),
          _buildQuestions(),
          _buildAnswerButtons(),
        ],
      ),
    );
  }

  Widget _buildScoreCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          QuizScoreCard(
              icon: Icons.check,
              color: Colors.green,
              score: scoreKeeper.correctAnswers()),
          Expanded(child: Container()),
          QuizScoreCard(
              icon: Icons.close,
              color: Colors.red,
              score: scoreKeeper.wrongAnswers()),
        ],
      ),
    );
  }

  Widget _buildQuestions() {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isGameOver
              ? QuizButton(
                  onPress: onRestart,
                  label: "Game Over!\nRestart",
                  color: Colors.green)
              : Text(
                  question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
        ),
      ),
    );
  }

  Widget _buildAnswerButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QuizButton(
            onPress: isGameOver ? null : () => onAnswer(true),
            label: "True",
            color: isGameOver ? Colors.grey : Colors.green,
            isExpanded: true,
          ),
          QuizButton(
            onPress: isGameOver ? null : () => onAnswer(false),
            label: "False",
            color: isGameOver ? Colors.grey : Colors.red,
            isExpanded: true,
          ),
        ],
      ),
    );
  }
}
