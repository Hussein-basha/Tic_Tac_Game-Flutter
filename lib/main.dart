import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_game/cubit/cubit.dart';
import 'package:tic_tac_game/cubit/states.dart';
import 'package:tic_tac_game/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicTacGameCubit(),
      child: BlocConsumer<TicTacGameCubit , TicTacGameStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.blue,
              primaryColor:  Color(0xFF00061a),
              shadowColor:  Color(0xFF001456),
              splashColor:  Color(0xFF4169e8),
            ),
            home:  HomeScreen(),
          );
        },
      ),
    );
  }
}
