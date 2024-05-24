import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, User;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/components/life_cycle_event_handler.dart';
import 'package:social_media_app/firebase_options.dart';
import 'package:social_media_app/landing/landing_page.dart';
import 'package:social_media_app/screens/mainscreen.dart';
import 'package:social_media_app/screens/mainscreenclient.dart';
import 'package:social_media_app/screens/mainscreentatooartist.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/services/user_service.dart';
import 'package:social_media_app/theme_observer.dart';
import 'package:social_media_app/utils/constants.dart';
import 'package:social_media_app/utils/providers.dart';
import 'package:social_media_app/view_models/theme/theme_view_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseAppCheck.instance // Only needed if you use App checks
  //     .installAppCheckProviderFactory(AppCheckProviderFactory(
  //         provider: SafetyNetAppCheckProviderFactory()));
  //  BlocOverrides.runZoned(
  //   () => runApp(const MyApp()),
  //   blocObserver: ThemeBlocObserver(),
  // );
  Bloc.observer = ThemeBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(
      LifecycleEventHandler(
        detachedCallBack: () => UserService().setUserStatus(false),
        resumeCallBack: () => UserService().setUserStatus(true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // AuthService auth = AuthService();
    // String? currentUserType ='';
    return MultiProvider(
      providers: providers,
      child: Consumer<ThemeProvider>(
        builder: (context, ThemeProvider notifier, Widget? child) {
          return MaterialApp(
            title: Constants.appName,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('fr'), // French
              Locale('es'), // Spanish
              Locale('ge'), // German
              Locale('it'), // Italian
            ],
            debugShowCheckedModeBanner: false,
            theme: themeData(
              notifier.dark ? Constants.darkTheme : Constants.lightTheme,
            ),
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: ((BuildContext context, snapshot) {
                // User user = auth.getCurrentUser();
              

                if (snapshot.hasData) {
//                   // Test if current user userType is CLIENT or TATTOARTIST
//                    FirebaseFirestore.instance
//                     .collection('users')
//                     .doc(user.uid)
//                     .get()
//                     .then(
//                       (value) => currentUserType = value.get('userType'),
//                     );
// // Suggested code may be subject to a license. Learn more: ~LicenseLog:14650707.
//                     print(currentUserType);
//                     if (currentUserType == 'CLIENT') {
//                       return const TabScreenClient();
//                     } else if (currentUserType == 'TATTOOARTIST') {
//                       return const TabScreenTatooArtist();
//                     } else{
//                       return const TabScreen();
//                   }
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2308876756.

                  return const TabScreen();
                } else {
                  return const Landing();
                }
              }),
            ),
          );
        },
      ),
    );
  }

  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
      textTheme: GoogleFonts.nunitoTextTheme(
        theme.textTheme,
      ),
    );
  }
}
