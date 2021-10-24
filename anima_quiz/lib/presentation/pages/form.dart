// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:anima_quiz/buisness_logic/cubits/image_cubit.dart';
import 'package:anima_quiz/buisness_logic/cubits/switch_cubit.dart';
import 'package:anima_quiz/buisness_logic/cubits/view_cubit.dart';
import 'package:anima_quiz/data/dataproviders/images_provider.dart';
import 'package:anima_quiz/data/dataproviders/questions_provider.dart';
import 'package:anima_quiz/data/models/question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<FormPage> {
  final QuestionsProvider _provider = QuestionsProvider();
  final ImagesProvider _img_provider = ImagesProvider();
  final TextEditingController _question_controller = TextEditingController();
  final TextEditingController _thematic_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Provider<ImageCubit>(
      create: (context) => ImageCubit(),
      child: BlocBuilder<ImageCubit, File?>(
        builder: (context, image) {
          return Provider<SwitchCubit>(
            create: (context) => SwitchCubit(),
            child: BlocBuilder<SwitchCubit, bool>(builder: (context, value) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'AJOUTEZ UNE QUESTION :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _question_controller,
                    style: const TextStyle(),
                    decoration: const InputDecoration(
                      hintText: "Entrez une question",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _thematic_controller,
                    style: const TextStyle(),
                    decoration: const InputDecoration(
                      hintText: "Entrez une thématique",
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'La question est-elle vraie ou fausse ?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'FAUX',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Switch(
                        activeColor: Theme.of(context).colorScheme.secondary,
                        value: value,
                        onChanged: (newValue) {
                          context.read<SwitchCubit>().switchValue(newValue);
                        },
                      ),
                      const Text(
                        'VRAI',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showPicker(context);
                    },
                    child: const Text('AJOUTER UNE IMAGE'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_question_controller.text.isNotEmpty &&
                          _thematic_controller.text.isNotEmpty &&
                          image != null) {
                        String uuid =
                            Uuid().v4() + "." + image.path.split('.').last;
                        Question question = Question(
                            questionText: _question_controller.text,
                            thematic: _thematic_controller.text,
                            isCorrect: value,
                            imagePath: uuid);
                        _img_provider.uploadImage(uuid, image).then((value) =>
                            _provider.addQuestion(question).then((value) {
                              final snackBar = SnackBar(
                                  content:
                                      const Text('La question a été ajoutée !'),
                                  backgroundColor: Colors.green.shade900);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              context.read<ViewCubit>().setValue('home');
                            }));
                      } else {
                        final snackBar = SnackBar(
                            content: const Text(
                                'Veuillez remplir tous les champs...'),
                            backgroundColor: Colors.red.shade900);

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: const Text('TERMINER'),
                  ),
                ],
              );
            }),
          );
        },
      ),
    );
  }

  void _imgFromCamera(BuildContext context) async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 100);

    context.read<ImageCubit>().uploadImage(image);
    final snackBar = SnackBar(
        content: const Text("L'image a été ajoutée !"),
        backgroundColor: Colors.green.shade900);

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _imgFromGallery(BuildContext context) async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);

    context.read<ImageCubit>().uploadImage(image);
    final snackBar = SnackBar(
        content: const Text("L'image a été ajoutée !"),
        backgroundColor: Colors.green.shade900);

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallerie'),
                    onTap: () {
                      _imgFromGallery(context);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Caméra'),
                  onTap: () {
                    _imgFromCamera(context);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    _question_controller.dispose();
    _thematic_controller.dispose();
    super.dispose();
  }
}
