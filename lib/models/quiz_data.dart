import 'package:flutter/foundation.dart';
import 'package:tockto_assignment/models/quiz.dart';

class QuizData extends ChangeNotifier {
  final List<Quiz> _quizzes = [];

  int _quizIndex = 0;

  void addQuiz(List<dynamic> data) {
    for (var d in data) {
      _quizzes.add(Quiz(d));
    }
  }

  int getQuizIndex() {
    return _quizIndex;
  }

  String getQuestion() {
    return _quizzes[_quizIndex].getQuestion();
  }

  List<String> getChoice() {
    return _quizzes[_quizIndex].getChoice();
  }

  List<bool> getChoicesState() {
    return _quizzes[_quizIndex].getChoicesState();
  }

  void toggleChoiceState(int choiceIndex) {
    _quizzes[_quizIndex].toggleChoiceState(choiceIndex);
    notifyListeners();
  }
}
