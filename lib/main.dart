import 'package:deldart/core/resources/app_theme.dart';
import 'package:deldart/core/services/bloc_observer.dart';
import 'package:deldart/features/home/cubit/home_cubit.dart';
import 'package:deldart/features/home/screens/home_screen.dart';
import 'package:deldart/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'di_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  await di.init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => di.sl<HomeCubit>()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DalDart',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
