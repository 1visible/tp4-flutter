import 'package:anima_quiz/buisness_logic/cubits/view_cubit.dart';
import 'package:anima_quiz/data/dataproviders/questions_provider.dart';
import 'package:anima_quiz/presentation/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final QuestionsProvider _provider = QuestionsProvider();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'AnimaQuiz',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        const Text(
          'CHOISISSEZ UNE CATÉGORIE :',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        FutureBuilder<List<String>>(
            future: _provider.getThematics(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Une erreur est survenue...');
              } else if (snapshot.hasData) {
                return Dropdown(thematics: snapshot.data!);
              } else {
                return const Text('Chargement en cours...');
              }
            }),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () {
            context.read<ViewCubit>().setValue('quiz');
          },
          child: const Text('JOUER AU QUIZ'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<ViewCubit>().setValue('form');
          },
          child: const Text('AJOUTER UNE QUESTION'),
        ),
      ],
    );
  }
}
