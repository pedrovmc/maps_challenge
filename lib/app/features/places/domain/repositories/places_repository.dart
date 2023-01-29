import 'package:dartz/dartz.dart';
import 'package:maps_challenge/app/core/errors/errors.dart';
import 'package:maps_challenge/app/features/places/domain/entities/detailed_place_entity.dart';
import 'package:maps_challenge/app/features/places/domain/entities/place_entity.dart';

abstract class PlacesRepository {
  Future<Either<Failure, List<PlaceEntity>>> searchPlace({
    required String input,
    required double currentLatitude,
    required double currentLongitude,
  });

  Future<Either<Failure, DetailedPlaceEntity>> getPlaceDetails(
      {required String placeId});
}
