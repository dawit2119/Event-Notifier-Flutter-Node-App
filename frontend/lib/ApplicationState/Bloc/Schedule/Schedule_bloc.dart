import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Repository/SchedulesRepository.dart';
import 'blocs.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleIntial());

  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    //LoadingScheduleEvent
    if (event is GetInitialState) {
      yield SchedulesIntialState();
    }
    else if (event is LoadAllSchedules) {
      yield LoadingSchedules();
      try {
        dynamic incommingvalue =
            await SchedulesRepository.allScheduleRepo(event.id);
        if (incommingvalue.runtimeType != String) {
          yield OnScheduleLoadSuccess(incommingvalue);
        } else {
          FaildLoadingSchedules(incommingvalue);
        }
      } catch (e) {
        FaildLoadingSchedules(e.toString());
        ;
      }
    }
      else if (event is UpdateSchedule) {
      yield ScheduleOperationsInProgress();
      try {
        print("update  is commig");
        print("event contains ${event.schedule}");
        final result = await SchedulesRepository.updateSchedule(event.schedule);
        if (result.runtimeType != String) {
          print("from bloc success");
          yield ScheduleCrudSuccess(result['update']);
        } else {
          yield ScheduleCrudFailed(result);
        }
      } catch (e) {
        yield ScheduleCrudFailed(e.toString());
      }
    }
    //AddingScheduleEvent

    else if (event is AddScheduleEvent) {
      dynamic responsemessage;
      yield ScheduleOperationsInProgress();
      try {
        var responsemessage =
            await SchedulesRepository.createSchedule(event.schedule);
        if (responsemessage.containsKey("Errormessage")) {
          yield ScheduleCrudFailed(responsemessage['Errormessage']);
        } else if (responsemessage.containsKey("message")) {
          print("responseMessage$responsemessage");
          yield ScheduleCrudSuccess(responsemessage.toString());
        } else {
          yield ScheduleCrudFailed(responsemessage);
        }
      } catch (e) {
        print(e.toString());
        // yield FailedtoAddSchedule(e.toString());
      }
    }
    else if (event is GetNotSeenNumber) {
      try {
        final result = await SchedulesRepository.getNotSeenResources(
            'getnotseennumber/${event.id}');
        print('result $result');
        if (result.runtimeType != String) {
          print("not seen number ${result['notseennumber']}");
          yield NotSeenNumberFound(result['notseennumber']);
        } else {
          yield FaildLoadingSchedules(result['message']);
        }
      } catch (e) {
        print("Error bloe ${e.toString()}");
      }
    }
    else if (event is GetNotSeenSchedules) {
      try {
        print("not seen is commig");
        final result = await SchedulesRepository.getNotSeenResources(
            'getnewschedules/${event.id}');
        if (result.runtimeType != String) {
          print("not seen schedules ${result['newSchedules']}");
          yield NotSeenSchedulesAreLoaded(result['newSchedules']);
        } else
          yield FaildLoadingSchedules(result['message']);
      } catch (e) {
        print("Error bloe ${e.toString()}");
        yield FaildLoadingSchedules("Error happened");
      }
    }
    else if (event is GetRepSchedules) {
      try {
        final result = await SchedulesRepository.getNotSeenResources(
            'getrepschedules/${event.id}');
        if (result.runtimeType != String) {
          print(
              "programs 1: ${result['allschedules'][0]['_doc']['programs'][0]}");
          yield RepSchedulesAreLoaded(result['allschedules']);
        } else
          yield FaildLoadingSchedules(result['message']);
      } catch (e) {
        print("Error bloc ${e.toString()}");
        yield FaildLoadingSchedules("Error happened");
      }
    }

    if (event is DeleteSchedule) {
      yield ScheduleOperationsInProgress();
      try {
        print("delete is commig");
        final result = await SchedulesRepository.deleteSchedule(event.schedule);
        if (result.runtimeType != String) {
          yield ScheduleCrudSuccess(result['delete']);
        } else {
          yield ScheduleCrudFailed(result);
        }
      } catch (e) {
        yield ScheduleCrudFailed(e.toString());
      }
    }
  }
}
