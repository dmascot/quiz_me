import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

/// This class loads one of the available Question bank from assets
///
/// private properties
///  - _questionAnswerBank: json loaded as dictionary from file
///  - _questionsSet: set of both true/false questions
///
/// private members:
/// - _loadQuestionBank: this function gets list of available question banks and
/// loads one randomly
///
/// - _createQuestionsSet: this functions extracts both true and false questions
/// merging into one single list
///
/// public members:
/// - initState: function to load question bank and create questions set, one
/// should use this function to initialise the QuestionBank object
///
/// - getQuestion: function to
///    -- pick random question from the list
///    -- remove question from the _questionsSet, so we never ask same question
///       twice in a game
///    -- return empty string if there are no more questions in _questionsSet
///
/// - isCorrectAnswer: function to return if correct answer was given
class QuestionBank {
  Map<String, dynamic> _questionAnswerBank = {};
  List<dynamic> _questionsSet = [];
  final Random _random = Random();

  Future<void> _loadQuestionBank() async {
    final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final questionBanks = assetManifest
        .listAssets()
        .where((path) => path.startsWith("assets/questionBank/"))
        .toList();

    final randomIndex = _random.nextInt(questionBanks.length);
    final randomQuestionsFile = questionBanks[randomIndex];

    final fileContent = await rootBundle.loadString(randomQuestionsFile);
    _questionAnswerBank = jsonDecode(fileContent);
  }

  _createQuestionsSet() {
    _questionAnswerBank.forEach((result, questions) {
      _questionsSet += questions;
    });
  }

  Future<void> initState() async {
    await _loadQuestionBank();
    _createQuestionsSet();
  }

  String getQuestion() {
    if (_questionsSet.isNotEmpty) {
      int index = _random.nextInt(_questionsSet.length);
      return _questionsSet.removeAt(index);
    }
    return "";
  }

  bool isCorrectAnswer({required bool answer, required String question}) {
    /// logic here is , if user answered "false" and, question is in dictionary
    /// of "false" , than user has answered correctly , thus answer is "correct'
    /// same can be said for "true"
    return _questionAnswerBank[answer.toString()].contains(question)
        ? true
        : false;
  }
}
