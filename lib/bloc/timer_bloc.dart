import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'timer_index.dart';
import 'package:flutter_timer/ticker.dart';


class TimerBloc extends Bloc<TimerEvent, TimerState>{
  final Ticker _ticker;
  final int _duration = 60;

  StreamSubscription<int> _tickerSubscription;

  TimerBloc({@required Ticker ticker})
    : assert(ticker != null),
      _ticker = ticker;

  @override
  TimerState get initialState => TimerInitial(_duration);

 

  @override
  Future<void> close(){
    _tickerSubscription?.cancel();
    return super.close();
  }

  Stream<TimerState> _mapTimerStartedToState(TimerStarted start) async*{
    yield TimerRunInProgress(start.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: start.duration).listen((duration) => add(TimerTicked(duration: duration)));
  }


  Stream<TimerState> _mapTimerPausedToState(TimerPause pause)async*{
    if(state is TimerRunInProgress){
      _tickerSubscription?.pause();
      yield TimerRunPause(state.duration);
    }
  }

  Stream<TimerState> _mapTimerResumedToState(TimerResumed  resume) async*{
    if(state is TimerRunPause){
      _tickerSubscription?.resume();
      yield TimerRunInProgress(state.duration);
    }
  }
  Stream<TimerState> _mapTimerResetToState(TimerReset reset)async*{
    _tickerSubscription?.cancel();
    yield TimerInitial(_duration);
  }

  Stream<TimerState> _mapTimerTickedToState(TimerTicked tick) async*{
    yield tick.duration > 0 ? TimerRunInProgress(tick.duration) : TimerRunComplete();
  }
  

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async*{
     if(event is TimerStarted){
      yield* _mapTimerStartedToState(event);
    } else if(event is TimerPause){
      yield* _mapTimerPausedToState(event);
    } else if (event is TimerResumed){
      yield* _mapTimerResumedToState(event);
    } else if(event is TimerReset){
      yield* _mapTimerResetToState(event);
    }else if(event is TimerTicked){
      yield* _mapTimerTickedToState(event);
    } 
  }

  
}