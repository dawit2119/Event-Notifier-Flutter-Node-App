import 'package:equatable/equatable.dart';
import 'package:frontend/Models/models.dart';

class HolyPlaceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingHolyPlacesEvent extends HolyPlaceEvent {}
class GetIntialState extends HolyPlaceEvent{}
class createHolyplaceEvent extends HolyPlaceEvent {
  final HolyplaceModel holyplaceModel;
  createHolyplaceEvent(this.holyplaceModel);
  @override
  List<Object?> get props => [holyplaceModel];
}

