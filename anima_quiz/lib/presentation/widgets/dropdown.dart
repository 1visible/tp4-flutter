import 'package:anima_quiz/buisness_logic/cubits/dropdown_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dropdown extends StatelessWidget {
  const Dropdown({Key? key, required this.thematics}) : super(key: key);

  final List<String> thematics;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropdownCubit, String>(builder: (context, value) {
      return DropdownButton(
        value: value,
        icon: const Icon(
          Icons.arrow_drop_down,
        ),
        onChanged: (String? val) {
          if (val != null) {
            context.read<DropdownCubit>().setValue(val);
          }
        },
        items: thematics
            .map(
              (val) => DropdownMenuItem(
                value: val,
                child: Text(
                  val,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
            .toList(),
      );
    });
  }
}
