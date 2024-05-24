// ignore_for_file: avoid_print
import 'package:bloc/bloc.dart';

class ThemeBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change.toString());
  }
}
