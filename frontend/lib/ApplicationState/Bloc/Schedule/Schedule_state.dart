import 'package:equatable/equatable.dart';
import 'package:frontend/Models/Schedule.dart';

class ScheduleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScheduleIntial extends ScheduleState {}

class LoadingSchedules extends ScheduleState {}

class OnScheduleLoadSuccess extends ScheduleState {
  List<dynamic> allschedules;

  OnScheduleLoadSuccess(this.allschedules);

  @override
  List<Object?> get props => [allschedules];
}

class FaildLoadingSchedules extends ScheduleState {
  final String message;

  FaildLoadingSchedules(this.message);
}

class ScheduleOperationsInProgress extends ScheduleState {}


class ScheduleCrudFailed extends ScheduleState {
  final String message;

  ScheduleCrudFailed(this.message);
}

class SchedulesIntialState extends ScheduleState {}

class NotSeenNumberFound extends ScheduleState {
  final int notSeenNumber;

  NotSeenNumberFound(this.notSeenNumber);
}

class NotSeenSchedulesAreLoaded extends ScheduleState {
  final dynamic schedules;

  NotSeenSchedulesAreLoaded(this.schedules);
}

class RepSchedulesAreLoaded extends ScheduleState {
  final dynamic postedSchedules;

  RepSchedulesAreLoaded(this.postedSchedules);
}

class ScheduleCrudSuccess extends ScheduleState {
  final String message;

  ScheduleCrudSuccess(this.message);
}
