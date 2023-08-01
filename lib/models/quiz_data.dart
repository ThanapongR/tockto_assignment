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

  List<String> getQuestionWords() {
    return _quizzes[_quizIndex].getQuestion().split('|');
  }

  int? getUserAnswer(int index) {
    return _quizzes[_quizIndex].getUserAnswers()[index];
  }

  List<String> getChoices() {
    return _quizzes[_quizIndex].getChoices();
  }

  int getAnswer(int index) {
    return _quizzes[_quizIndex].getAnswers()[index];
  }

  //Check answers
  bool checkAnswer(int index) {
    if (getUserAnswer(index) == getAnswer(index)) {
      return true;
    } else {
      return false;
    }
  }

  //Check answers
  bool checkAllAnswer() {
    List<int> solution = _quizzes[_quizIndex].getAnswers();
    for (int index = 0; index < solution.length; index++) {
      if (getUserAnswer(index) != getAnswer(index)) {
        return false;
      }
    }
    return true;
  }

  //Get the number of answers from the user.
  int getAnswerCount() {
    return _quizzes[_quizIndex].getAnswerCount();
  }

  //Get answer to show in blank space
  String? getAnswerByIndex(int index) {
    int? answer = getUserAnswer(index);
    if (answer != null) {
      return getChoices()[answer];
    } else {
      return null;
    }
  }

  //Get state of choice
  List<bool> getChoicesState() {
    return _quizzes[_quizIndex].getChoicesState();
  }

  //Toggle choice state
  void toggleChoiceState(int index) {
    _quizzes[_quizIndex].toggleChoiceState(index);
    notifyListeners();
  }

  //Goto next question
  void nextQuiz() {
    _quizIndex++;
    if (_quizIndex > _quizzes.length - 1) {
      _quizIndex = 0;
    }
  }

  //Clear user data
  void clearData() {
    _quizzes[_quizIndex].clearData();
    notifyListeners();
  }
}
