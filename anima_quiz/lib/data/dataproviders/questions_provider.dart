import 'package:anima_quiz/data/models/question.dart';
import 'package:anima_quiz/data/repositories/questions_repository.dart';

class QuestionsProvider {
  final QuestionsRepository _repository = QuestionsRepository();

  Future<List<Question>> getQuestions() async {
    return await _repository.getQuestions().then((data) =>
        data.docs.map((value) => Question.fromJson(value.data())).toList());
  }

  Future<List<Question>> getQuestionsByThematic(String thematic) async {
    return await _repository.getQuestionsByThematic(thematic).then((data) =>
        data.docs.map((value) => Question.fromJson(value.data())).toList());
  }

  Future<List<String>> getThematics() async {
    return await _repository.getQuestions().then((data) => data.docs
        .map((value) => Question.fromJson(value.data()).thematic)
        .toList()
        .toSet()
        .toList());
  }

  Future<void> addQuestion(Question question) async {
    await _repository.addQuestion(question.toJson());
  }
}
