 import 'package:flutter/material.dart';
import 'package:flutter_timer/bloc/timer_index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ticker.dart';
import 'timer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primaryColor: Colors.fromRGBO(109,234,255,1),
        // accentColor: Colors.fromRGBO(72, 74, 126, 1),
        primaryColor: Color.fromRGBO(109, 234, 255, 1),
        accentColor: Color.fromRGBO(72, 74, 126, 1),
        brightness: Brightness.dark,
      ),
      title: 'Timer',
      home: BlocProvider<TimerBloc>(
        create: (context) => TimerBloc(ticker: Ticker()),
        child: Timer(),
        ),
    );
  }
}