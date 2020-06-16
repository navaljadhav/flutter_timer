import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class TimerState extends Equatable{
  final int duration;

  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

// TimerInitial — ready to start counting down from the specified duration.
// TimerRunInProgress — actively counting down from the specified duration.
// TimerRunPause — paused at some remaining duration.
// TimerRunComplete — completed with a remaining duration of 0.

class TimerInitial extends TimerState{
  const TimerInitial(int duration) : super(duration);
  @override
  String toString() => 'TimerInital {duration : $duration }';
}

class TimerRunPause extends TimerState{
  const TimerRunPause(int duration) : super(duration);
  @override
  String toString() =>  'TimerRunPause { duration: $duration }';
}

class TimerRunInProgress extends TimerState{
  const TimerRunInProgress(int duration) : super(duration);
  @override
  String toString() => 'TimerRunInProgress { duration: $duration }';
}

class TimerRunComplete extends TimerState{
  const TimerRunComplete() : super(0);
}

