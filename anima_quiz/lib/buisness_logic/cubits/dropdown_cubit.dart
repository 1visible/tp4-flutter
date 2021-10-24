import 'package:flutter_bloc/flutter_bloc.dart';

class DropdownCubit extends Cubit<String> {
  DropdownCubit(String initialState) : super(initialState);

  setValue(String value) => emit(value);
}
