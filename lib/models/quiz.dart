class Quiz {
  String _question = '';
  final List<int?> _questionAnswer = [];
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
      _questionAnswer.add(null);
    }
  }

  String getQuestion() {
    return _question;
  }

  List<int?> getQuestionAnswer() {
    return _questionAnswer;
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
      for (int i = 0; i < _questionAnswer.length; i++) {
        if (_questionAnswer[i] == choiceIndex) {
          _questionAnswer[i] = null;
          break;
        }
      }
    } else {
      if (_questionAnswer.contains(null)) {
        for (int i = 0; i < _questionAnswer.length; i++) {
          if (_questionAnswer[i] == null) {
            _questionAnswer[i] = choiceIndex;
            break;
          }
        }
        print('xxx');
        _choicesState[choiceIndex] = true;
      }
    }
    print(_questionAnswer);
  }
}
