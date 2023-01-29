import 'package:maps_challenge/app/core/errors/errors.dart';
import 'package:maps_challenge/app/features/places/domain/entities/place_entity.dart';

abstract class SearchPlacesState {}

class SearchPlacesInitialState implements SearchPlacesState {
  const SearchPlacesInitialState();
}

class SearchPlacesLoadingState implements SearchPlacesState {
  const SearchPlacesLoadingState();
}

class SearchPlacesErrorState implements SearchPlacesState {
  final Failure error;
  SearchPlacesErrorState(this.error);
}

class SearchPlacesSuccessState implements SearchPlacesState {
  final List<PlaceEntity> places;
  SearchPlacesSuccessState(this.places);
}
