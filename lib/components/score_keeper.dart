/// class is to keep the score as in count of correct and wrong answers
///
/// private properties:
///  _correctAnswers: keeps count of correct answers
///  _wrongAnswers: keeps count of incorrect answers
///
/// public members:
/// - correctAnswers: returns count of correct answers
/// - wrongAnswers: returns count of wrong answers
/// - increment: increments count of correct or wrong answer based on fact
///   if answer isCorrect true or false
/// - reset: sets both correct and wrong answers count to 0
class ScoreKeeper {
  int _correctAnswers = 0;
  int _wrongAnswers = 0;

  int correctAnswers() {
    return _correctAnswers;
  }

  int wrongAnswers() {
    return _wrongAnswers;
  }

  void incrementScore({required bool isCorrect}) {
    isCorrect ? _correctAnswers++ : _wrongAnswers++;
  }

  void reset() {
    _correctAnswers = 0;
    _wrongAnswers = 0;
  }
}
