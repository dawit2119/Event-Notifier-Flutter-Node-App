import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/ApplicationState/Bloc/Holyplace/blocs.dart';
import 'package:frontend/Models/models.dart';

void main() {
  HolyplaceModel mockHolyplaceModel = HolyplaceModel("orthodox", "sibket",
      location: "addis ababa",
      history: "This is history",
      image: "https://images.jpg");
  group("HolyPlace bloc test", () {
    blocTest<HolyPlaceBloc, HolyPlaceState>(
      'emits [] when nothing is added i.e before injected',
      build: () {
        return HolyPlaceBloc();
      },
      expect: () => <HolyPlaceState>[],
    );
    // The holy places are loaded
    blocTest<HolyPlaceBloc, HolyPlaceState>(
      'When the screen is initialized',
      build: () {
        return HolyPlaceBloc();
      },
      act: (bloc) {
        return bloc.add(GetIntialState());
      },
      wait: const Duration(milliseconds: 1000),
      expect: () {
        return [isA<HolyPlaceState>()];
      },
    );

    blocTest<HolyPlaceBloc, HolyPlaceState>(
      'Creating holy place',
      build: () {
        return HolyPlaceBloc();
      },
      act: (bloc) {
        return bloc.add(createHolyplaceEvent(mockHolyplaceModel));
      },
      wait: const Duration(milliseconds: 1000),
      expect: () {
        return [isA<HolyPlaceState>(), isA<HolyPlaceState>()];
      },
    );
  });
}
