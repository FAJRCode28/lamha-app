import '../models/place_model.dart';

abstract class PlacesState {}

class PlacesInitial extends PlacesState {}

class PlacesLoading extends PlacesState {}

class PlacesSuccess extends PlacesState {
  final List<PlaceModel> places;

  PlacesSuccess(this.places);
}

class PlacesError extends PlacesState {
  final String message;

  PlacesError(this.message);
}