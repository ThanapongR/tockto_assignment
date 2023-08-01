class Quiz {
  String _question = '';
  List<int?> _answer = [];
  List<String> _choices = [];
  List<bool> _choicesState = [];
  List<int> _solutions = [];
  int _answerCount = 0;

  Quiz(Map<String, dynamic> data) {
    _question = data['text'] ?? '';
    _choices =
        List.from(data['choices']).map((item) => item.toString()).toList();
    _solutions = List.from(data['solutions'])
        .map((item) => int.tryParse(item.toString()) ?? 0)
        .toList();

    for (var _ in _solutions) {
      _answer.add(null);
    }

    for (var _ in _choices) {
      _choicesState.add(false);
    }
  }

  String getQuestion() {
    return _question;
  }

  List<int?> getAnswer() {
    return _answer;
  }

  List<String> getChoice() {
    return _choices;
  }

  List<bool> getChoicesState() {
    return _choicesState;
  }

  List<int> getSolution() {
    return _solutions;
  }

  int getAnswerCount() {
    return _answerCount;
  }

  void toggleChoiceState(int choiceIndex) {
    if (_choicesState[choiceIndex]) {
      _choicesState[choiceIndex] = false;
      for (int i = 0; i < _answer.length; i++) {
        if (_answer[i] == choiceIndex) {
          _answer[i] = null;
          break;
        }
      }
      _answerCount--;
    } else {
      if (_answer.contains(null)) {
        for (int i = 0; i < _answer.length; i++) {
          if (_answer[i] == null) {
            _answer[i] = choiceIndex;
            break;
          }
        }
        _choicesState[choiceIndex] = true;
        _answerCount++;
      }
    }
  }

  void clearData() {
    _answer = [];
    _choicesState = [];
    for (var _ in _solutions) {
      _answer.add(null);
    }
    for (var _ in _choices) {
      _choicesState.add(false);
    }
    _answerCount = 0;
  }
}
