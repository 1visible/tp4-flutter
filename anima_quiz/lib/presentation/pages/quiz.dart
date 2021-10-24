import 'package:anima_quiz/buisness_logic/cubits/question_cubit.dart';
import 'package:anima_quiz/data/dataproviders/images_provider.dart';
import 'package:anima_quiz/data/dataproviders/questions_provider.dart';
import 'package:anima_quiz/data/models/question.dart';
import 'package:anima_quiz/presentation/pages/other.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../buisness_logic/utils/container.dart';

class QuizPage extends StatelessWidget {
  QuizPage({Key? key, required this.thematic}) : super(key: key);

  final String thematic;
  final QuestionsProvider _provider = QuestionsProvider();
  final ImagesProvider _img_provider = ImagesProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _provider.getQuestionsByThematic(thematic),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const OtherPage(text: 'Une erreur est survenue...');
          } else if (snapshot.hasData) {
            return Provider<QuestionCubit>(
              create: (_) =>
                  QuestionCubit(questions: snapshot.data! as List<Question>),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height / 2.5,
                          maxWidth: MediaQuery.of(context).size.width,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: BlocBuilder<QuestionCubit, QuestionContainer>(
                              builder: (context, container) {
                            return FutureBuilder<String>(
                              future: _img_provider
                                  .getImage(container.question.imagePath),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Image.network(snapshot.data!);
                                } else {
                                  return Image.asset('images/loading.jpg');
                                }
                              },
                            );
                          }),
                        )),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: BlocBuilder<QuestionCubit, QuestionContainer>(
                        builder: (context, container) => Text(
                          container.question.questionText,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          BlocBuilder<QuestionCubit, QuestionContainer>(
                              builder: (context, container) {
                            if (container.isEnabled) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (container.isEnabled) {
                                    context
                                        .read<QuestionCubit>()
                                        .checkAnswer(true, context);
                                  }
                                },
                                child: const Text('VRAI'),
                              );
                            }
                            return const SizedBox(width: 0, height: 0);
                          }),
                          BlocBuilder<QuestionCubit, QuestionContainer>(
                              builder: (context, container) {
                            if (container.isEnabled) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (container.isEnabled) {
                                    context
                                        .read<QuestionCubit>()
                                        .checkAnswer(false, context);
                                  }
                                },
                                child: const Text('FAUX'),
                              );
                            }
                            return const Text(
                                "Merci d'avoir joué à AnimaQuiz !",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ));
                          }),
                          BlocBuilder<QuestionCubit, QuestionContainer>(
                              builder: (context, container) {
                            if (container.isEnabled) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (container.isEnabled) {
                                    context
                                        .read<QuestionCubit>()
                                        .nextQuestion();
                                  }
                                },
                                child: const Icon(Icons.arrow_right_alt),
                              );
                            }
                            return const SizedBox(width: 0, height: 0);
                          }),
                        ]),
                    BlocBuilder<QuestionCubit, QuestionContainer>(
                        builder: (context, container) =>
                            Text('Bonnes réponses : ${container.counter}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))),
                  ]),
            );
          } else {
            return const OtherPage(text: 'Chargement en cours...');
          }
        });
  }
}
