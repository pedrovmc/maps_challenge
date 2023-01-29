import 'package:dartz/dartz.dart';
import 'package:maps_challenge/app/core/errors/errors.dart';
import 'package:maps_challenge/app/features/places/domain/entities/detailed_place_entity.dart';

abstract class GetPlaceDetailsUsecase {
  Future<Either<Failure, DetailedPlaceEntity>> call({required String placeId});
}
