class Quiz {
  String _question = ''; //Question sentence
  final List<int?> _userAnswer = []; //User answer
  List<String> _choices = []; //Choices
  final List<bool> _choicesState = []; //Choices state (true, false)
  List<int> _answer = []; //Question answer

  int _userAnswerCount = 0; //Number of answer from user

  //Add data
  Quiz(Map<String, dynamic> data) {
    _question = data['text'] ?? '';
    _choices =
        List.from(data['choices']).map((item) => item.toString()).toList();
    _answer = List.from(data['solutions'])
        .map((item) => int.tryParse(item.toString()) ?? 0)
        .toList();

    for (var _ in _answer) {
      _userAnswer.add(null);
    }

    for (var _ in _choices) {
      _choicesState.add(false);
    }
  }

  String getQuestion() {
    return _question;
  }

  List<int?> getUserAnswers() {
    return _userAnswer;
  }

  List<String> getChoices() {
    return _choices;
  }

  List<bool> getChoicesState() {
    return _choicesState;
  }

  List<int> getAnswers() {
    return _answer;
  }

  int getAnswerCount() {
    return _userAnswerCount;
  }

  //Toggle choice state
  void toggleChoiceState(int choiceIndex) {
    if (_choicesState[choiceIndex]) {
      _choicesState[choiceIndex] = false;
      for (int i = 0; i < _userAnswer.length; i++) {
        if (_userAnswer[i] == choiceIndex) {
          _userAnswer[i] = null;
          break;
        }
      }
      _userAnswerCount--;
    } else {
      if (_userAnswer.contains(null)) {
        for (int i = 0; i < _userAnswer.length; i++) {
          if (_userAnswer[i] == null) {
            _userAnswer[i] = choiceIndex;
            break;
          }
        }
        _choicesState[choiceIndex] = true;
        _userAnswerCount++;
      }
    }
  }

  //Clear user data
  void clearData() {
    _userAnswerCount = 0;
    _userAnswer.clear();
    _choicesState.clear();

    for (var _ in _answer) {
      _userAnswer.add(null);
    }
    for (var _ in _choices) {
      _choicesState.add(false);
    }
  }
}
