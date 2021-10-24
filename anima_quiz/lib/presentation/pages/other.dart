import 'package:flutter/material.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 2.5,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset('images/loading.jpg'),
              )),
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ]);
  }
}
