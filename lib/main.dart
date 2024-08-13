import 'package:flutter/material.dart';
import 'package:quiz_me/components/data/question_bank.dart';
import 'package:quiz_me/components/score_keeper.dart';
import 'package:quiz_me/components/ui/audio.dart';
import 'package:quiz_me/layout.dart';

/// main function to run an app
void main() {
  runApp(const App());
}

/// App class to provide the core layout it defines
/// - app title
/// - back ground colour
/// - safe are for app layout
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title:
              const Align(alignment: Alignment.center, child: Text("QuizMe!")),
          titleTextStyle: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        body: const SafeArea(child: Quiz()),
      ),
    );
  }
}

/// stateful class to implement dynamic details
class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

/// private QuizState class where we actually manage state of the app
///
/// private properties:
/// - _questionBank: an instance of QuestionBank class to
///    -- fetch question
///    --  check the answer
/// - _audioPlayer: and instance of Audio() class to play
///    -- looping background music
///    -- appropriate music for correct and wrong answers
/// - _score: an instance of ScoreKeeper to
///    -- increment appropriate score count depending upon weather answer is
///    correct or wrong
///    -- keep account of score
/// - _currentQuestion: current question to be displayed on the screen
/// - _isGameOver: status of the current game
///
/// private members:
/// - _initQuiz: This function
///   -- initiate the quiz
///   -- starts background  music loop
///   -- sets current questions
///   -- resets score
///   -- sets _isGameOver to false
///
/// - _setQuestion: This function
///   -- sets current question , picking it from QuizBank
///   -- if there are no more questions left
///       --- sets _isGameOver to true
///       --- stops background music loop
/// - _handleAnswer: This function is passed to Layout as callback for onAnswer
///   -- it checks if answer is correct or not using QuiZBank member
///      isCorrectAnswer
///   -- plays appropriate short audio for correct or incorrect answer
///   -- updates the score card for correct and incorrect answer
///   -- fetch the next question
class _QuizState extends State<Quiz> {
  final QuestionBank _questionBank = QuestionBank();
  final Audio _audioPlayer = Audio();
  final ScoreKeeper _scoreKeeper = ScoreKeeper();

  String _currentQuestion = "Loading....";
  bool _isGameOver = false;

  @override
  void initState() {
    super.initState();
    _initQuiz();
  }

  void _initQuiz() async {
    await _questionBank.initState();
    _audioPlayer.playGapLessLoop(["assets/audio/ambient.wav"]);
    setState(() {
      _setQuestion();
      _scoreKeeper.reset();
      _isGameOver = false;
    });
  }

  void _setQuestion() {
    _currentQuestion = _questionBank.getQuestion();
    if (_currentQuestion.isEmpty) {
      _isGameOver = true;
      _audioPlayer.stopGapLessLoop();
    }
  }

  void _handleAnswer(bool answer) {
    bool isCorrect = _questionBank.isCorrectAnswer(
        answer: answer, question: _currentQuestion);
    isCorrect
        ? _audioPlayer.playShortAudio("assets/audio/success.mp3")
        : _audioPlayer.playShortAudio("assets/audio/wrong.wav");

    setState(() {
      _scoreKeeper.incrementScore(isCorrect: isCorrect);
      _setQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        question: _currentQuestion,
        onAnswer: _handleAnswer,
        isGameOver: _isGameOver,
        scoreKeeper: _scoreKeeper,
        onRestart: _initQuiz);
  }
}
