import 'package:maps_challenge/app/core/errors/errors.dart';
import 'package:maps_challenge/app/features/places/domain/entities/detailed_place_entity.dart';

abstract class PlaceDetailsState {}

class PlaceDetailsInitialState implements PlaceDetailsState {
  const PlaceDetailsInitialState();
}

class PlaceDetailsLoadingState implements PlaceDetailsState {
  const PlaceDetailsLoadingState();
}

class PlaceDetailsErrorState implements PlaceDetailsState {
  final Failure error;
  PlaceDetailsErrorState(this.error);
}

class PlaceDetailsSuccessState implements PlaceDetailsState {
  final DetailedPlaceEntity detailedPlaceEntity;
  PlaceDetailsSuccessState(this.detailedPlaceEntity);
}
