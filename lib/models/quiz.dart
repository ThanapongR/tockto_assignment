class Quiz {
  String _question = '';
  final List<int?> _answer = [];
  List<String> _choices = [];
  final List<bool> _choicesState = [];
  List<int> _solutions = [];

  Quiz(Map<String, dynamic> data) {
    _question = data['text'] ?? '';
    _choices =
        List.from(data['choices'])?.map((item) => item.toString()).toList() ??
            [];
    _solutions = List.from(data['solutions'])
            ?.map((item) => int.tryParse(item.toString()) ?? 0)
            .toList() ??
        [];

    for (var _ in _choices) {
      _choicesState.add(false);
    }

    for (var _ in _solutions) {
      _answer.add(null);
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

  void toggleChoiceState(int choiceIndex) {
    if (_choicesState[choiceIndex]) {
      _choicesState[choiceIndex] = false;
      for (int i = 0; i < _answer.length; i++) {
        if (_answer[i] == choiceIndex) {
          _answer[i] = null;
          break;
        }
      }
    } else {
      if (_answer.contains(null)) {
        for (int i = 0; i < _answer.length; i++) {
          if (_answer[i] == null) {
            _answer[i] = choiceIndex;
            break;
          }
        }
        _choicesState[choiceIndex] = true;
      }
    }
    print(_answer);
  }
}
