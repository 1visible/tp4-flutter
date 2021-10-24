import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/container.dart';
import '../../data/models/question.dart';

class QuestionCubit extends Cubit<QuestionContainer> {
  final List<Question> questions;
  bool _isEnabled = true;
  int _counter = 0;
  int _questionNumber = 0;
  late Question _question;

  int get questionNumber => _questionNumber;

  QuestionCubit({required this.questions})
      : super(QuestionContainer(
            true,
            0,
            Question(
                questionText: "Chargement en cours...",
                isCorrect: true,
                thematic: '',
                imagePath: "images/loading.jpg"))) {
    _question = questions[_questionNumber];
    emit(QuestionContainer(_isEnabled, _counter, _question));
  }

  checkAnswer(bool userChoice, BuildContext context) {
    String text;
    Color color;

    if (_question.isCorrect == userChoice) {
      text = 'Vous avez la bonne réponse !';
      color = Colors.green.shade900;
      _counter++;
    } else {
      text = 'Vous vous êtes trompé(e)...';
      color = Colors.red.shade900;
    }

    final snackBar = SnackBar(
        content: Text(text),
        backgroundColor: color,
        duration: const Duration(milliseconds: 500));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    nextQuestion();
  }

  nextQuestion() {
    if (_questionNumber < questions.length - 1) {
      _questionNumber++;
      _question = questions[_questionNumber];
    } else {
      _isEnabled = false;
    }

    emit(QuestionContainer(_isEnabled, _counter, _question));
  }
}
