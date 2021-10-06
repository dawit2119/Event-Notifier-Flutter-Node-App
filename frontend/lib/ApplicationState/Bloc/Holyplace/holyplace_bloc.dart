import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Repository/HolyplaceRepository.dart';
import 'blocs.dart';

class HolyPlaceBloc extends Bloc<HolyPlaceEvent, HolyPlaceState> {
  HolyPlaceBloc() : super(HolyPlacesIntialState());

  @override
  Stream<HolyPlaceState> mapEventToState(HolyPlaceEvent event) async* {
    //LoadingHolyplace
    if (event is GetIntialState) {
      yield HolyPlacesIntialState();
    }
    if (event is LoadingHolyPlacesEvent) {
      yield LoadingHolyPlaces();
      try {
        dynamic incommingvalue = await HolyPlaceRepository.getAllHolyplaces();
        yield OnHolyPlaceLoadSuccess(incommingvalue);
      } catch (e) {
        FaildtoLoadingHolyPlaces();
        ;
      }
    }
    if (event is createHolyplaceEvent) {
      yield LoadingHolyPlaces();
      try {
        print("before this");
        dynamic message =
            await HolyPlaceRepository.createHolyPlace(event.holyplaceModel);
        print("Messgage $message");
        if (message.runtimeType != String) {
                    yield onCreateHolyPlaceSucess(message['message']);
        } else
          yield FaildtoCreateHolyplace();
      } catch (e) {
        yield FaildtoCreateHolyplace();
      }
    }
  }
}
