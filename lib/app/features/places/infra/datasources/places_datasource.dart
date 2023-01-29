import 'package:maps_challenge/app/features/places/domain/entities/detailed_place_entity.dart';
import 'package:maps_challenge/app/features/places/domain/entities/place_entity.dart';

abstract class PlacesDatasource {
  Future<List<PlaceEntity>> searchPlace({
    required String input,
    required double currentLatitude,
    required double currentLongitude,
  });

  Future<DetailedPlaceEntity> getPlaceDetails({required String placeId});
}
