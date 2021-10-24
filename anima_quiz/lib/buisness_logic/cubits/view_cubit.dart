import 'package:flutter_bloc/flutter_bloc.dart';

class ViewCubit extends Cubit<String> {
  ViewCubit(String initialState) : super(initialState);

  setValue(String value) => emit(value);
}
