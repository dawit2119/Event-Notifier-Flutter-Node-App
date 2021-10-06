import 'package:equatable/equatable.dart';

class HolyPlaceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingHolyPlaces extends HolyPlaceState {}
class HolyPlacesIntialState extends HolyPlaceState{}
class OnHolyPlaceLoadSuccess extends HolyPlaceState {
  List<dynamic> allholyplaces;

  OnHolyPlaceLoadSuccess(this.allholyplaces);

  @override
  List<Object?> get props => [allholyplaces];
}

class FaildtoLoadingHolyPlaces extends HolyPlaceState {}

class onCreateHolyPlaceSucess extends HolyPlaceState {
  String responsemessage;
  onCreateHolyPlaceSucess(this.responsemessage);

  @override
  List<Object?> get props => [responsemessage];
}

class FaildtoCreateHolyplace extends HolyPlaceState {}
