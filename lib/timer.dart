
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/actions.dart';
import 'package:flutter_timer/bloc/timer_index.dart';
import 'package:flutter_timer/waves_background.dart';

class Timer extends StatelessWidget {
  static const TextStyle timerTextStyle = TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Timer'),centerTitle: true,),
      body: Stack(
          
          children: [
            Background(),
           Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 100.0),
              child: Center(
                child: BlocBuilder<TimerBloc, TimerState>(
                  builder: (context, state){
                    final String minutesStr = 
                      ((state.duration/60) % 60).floor().toString().padLeft(2, '0');
                    final String secondsStr =
                      (state.duration % 60).floor().toString().padLeft(2, '0');
                    return Text(
                      '$minutesStr:$secondsStr',
                      style: Timer.timerTextStyle,
                    );
                  },
                ),
              ),
            ),
            BlocBuilder<TimerBloc,TimerState>(
              condition: (previousState, state) => state.runtimeType != previousState.runtimeType,
              builder: (context, state) => Acts(),
              ),
          ],
        ),
          ],
      ),
      
    );
  }
}