import 'package:dartz/dartz.dart';
import 'package:maps_challenge/app/core/errors/errors.dart';
import 'package:maps_challenge/app/features/places/domain/entities/place_entity.dart';

abstract class SearchPlacesUsecase {
  Future<Either<Failure, List<PlaceEntity>>> call({
    required String input,
    required double currentLatitude,
    required double currentLongitude,
  });
}
