import 'package:anima_quiz/buisness_logic/cubits/dropdown_cubit.dart';
import 'package:anima_quiz/buisness_logic/notifiers/theme_notifier.dart';
import 'package:anima_quiz/presentation/pages/home.dart';
import 'package:anima_quiz/presentation/pages/other.dart';
import 'package:anima_quiz/presentation/pages/quiz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'buisness_logic/cubits/view_cubit.dart';
import 'presentation/screens/screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _init = Firebase.initializeApp();

  static ColorScheme lightScheme = const ColorScheme.light().copyWith(
      primary: const Color(0xFF66bb6a),
      primaryVariant: const Color(0xFF66bb6a),
      secondary: const Color(0xFF8c6d62),
      secondaryVariant: const Color(0xFF8c6d62));

  static ColorScheme darkScheme = const ColorScheme.dark().copyWith(
      primary: const Color(0xFF66bb6a),
      primaryVariant: const Color(0xFF66bb6a),
      secondary: const Color(0xFF8c6d62),
      secondaryVariant: const Color(0xFF8c6d62));

  @override
  Widget build(BuildContext context) {
    return Provider<ViewCubit>(
      create: (context) => ViewCubit('home'),
      child: BlocBuilder<ViewCubit, String>(builder: (context, view) {
        return ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
          builder: (context, _) {
            final theme = Provider.of<ThemeNotifier>(context);
            return MaterialApp(
              title: 'Questions/Réponses',
              themeMode: theme.mode,
              theme: ThemeData.light().copyWith(colorScheme: lightScheme),
              darkTheme: ThemeData.dark().copyWith(colorScheme: darkScheme),
              home: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text('Questions/Réponses'),
                  actions: <Widget>[
                    Switch(
                      value: theme.getThemeMode(),
                      onChanged: (value) {
                        final provider =
                            Provider.of<ThemeNotifier>(context, listen: false);
                        provider.setThemeMode(value);
                      },
                    ),
                  ],
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context.read<ViewCubit>().setValue('home');
                    },
                  ),
                ),
                body: Screen(init: _init),
              ),
            );
          },
        );
      }),
    );
  }
}
