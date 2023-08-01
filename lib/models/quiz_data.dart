import 'package:flutter/foundation.dart';
import 'package:tockto_assignment/models/quiz.dart';

class QuizData extends ChangeNotifier {
  final List<Quiz> _quizzes = [];

  int _quizIndex = 0;

  void addQuiz(List<dynamic> data) {
    if (!_quizzes.isNotEmpty) {
      for (var d in data) {
        _quizzes.add(Quiz(d));
      }
    }
  }

  int getQuizIndex() {
    return _quizIndex;
  }

  List<String> getQuestion() {
    return _quizzes[_quizIndex].getQuestion().split('|');
  }

  int? getAnswer(int index) {
    return _quizzes[_quizIndex].getAnswer()[index];
  }

  List<String> getChoice() {
    return _quizzes[_quizIndex].getChoice();
  }

  int getSolution(int index) {
    return _quizzes[_quizIndex].getSolution()[index];
  }

  bool checkAnswer(int index) {
    if (getAnswer(index) == getSolution(index)) {
      return true;
    } else {
      return false;
    }
  }

  bool checkAllAnswer() {
    List<int> solution = _quizzes[_quizIndex].getSolution();
    for (int index = 0; index < solution.length; index++) {
      if (getAnswer(index) != getSolution(index)) {
        return false;
      }
    }
    return true;
  }

  int getAnswerCount() {
    return _quizzes[_quizIndex].getAnswerCount();
  }

  //Get answer to show in blank space
  String? getAnswerByIndex(int index) {
    int? answer = getAnswer(index);
    if (answer != null) {
      return getChoice()[answer];
    } else {
      return null;
    }
  }

  List<bool> getChoicesState() {
    return _quizzes[_quizIndex].getChoicesState();
  }

  void toggleChoiceState(int choiceIndex) {
    _quizzes[_quizIndex].toggleChoiceState(choiceIndex);
    notifyListeners();
  }

  void nextQuiz() {
    if (++_quizIndex > _quizzes.length - 1) {
      _quizIndex = 0;
    }
  }

  void clearData() {
    _quizzes[_quizIndex].clearData();
    notifyListeners();
  }
}
