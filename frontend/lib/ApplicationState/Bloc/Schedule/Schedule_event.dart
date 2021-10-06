import 'package:equatable/equatable.dart';
import 'package:frontend/Models/Schedule.dart';

class ScheduleEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAllSchedules extends ScheduleEvent {
  final String id;

  LoadAllSchedules(this.id);
}

class AddScheduleEvent extends ScheduleEvent {
  final Schedule schedule;
  AddScheduleEvent(this.schedule);

  @override
  List<Object?> get props => [];
}

class GetInitialState extends ScheduleEvent {}

class GetNotSeenNumber extends ScheduleEvent {
  final String id;

  GetNotSeenNumber(this.id);
}

class GetNotSeenSchedules extends ScheduleEvent {
  final String id;

  GetNotSeenSchedules(this.id);
}

class GetRepSchedules extends ScheduleEvent {
  final String id;

  GetRepSchedules(this.id);
}

class UpdateSchedule extends ScheduleEvent {
  final Schedule schedule;
  UpdateSchedule(this.schedule);
}
class DeleteSchedule extends ScheduleEvent {
  final Schedule schedule;

  DeleteSchedule(this.schedule);
}
