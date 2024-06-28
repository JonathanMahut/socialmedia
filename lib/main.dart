import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/app/app.dart';
import 'package:social_media_app/firebase_options.dart';
import 'package:social_media_app/presentation/blocs/theme_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Bloc.observer = ThemeBlocObserver();
  runApp(const MyApp());
}
