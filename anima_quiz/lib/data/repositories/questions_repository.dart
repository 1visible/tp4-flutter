import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionsRepository {
  final _questions = FirebaseFirestore.instance.collection('questions');

  Future<QuerySnapshot> getQuestions() {
    return _questions.get();
  }

  Future<QuerySnapshot> getQuestionsByThematic(String thematic) {
    return _questions.where('thematic', isEqualTo: thematic).get();
  }

  Future<DocumentReference> addQuestion(Map<String, dynamic> question) {
    return _questions.add(question);
  }
}
