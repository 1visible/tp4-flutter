import '../../data/models/question.dart';

class QuestionContainer {
  final bool _isEnabled;
  final int _counter;
  final Question _question;

  QuestionContainer(this._isEnabled, this._counter, this._question);

  bool get isEnabled => _isEnabled;
  int get counter => _counter;
  Question get question => _question;
}
