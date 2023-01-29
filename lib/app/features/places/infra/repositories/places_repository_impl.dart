import 'package:dartz/dartz.dart';
import 'package:maps_challenge/app/core/rest_client/rest_client_exception.dart';
import 'package:maps_challenge/app/features/places/domain/entities/detailed_place_entity.dart';
import 'package:maps_challenge/app/features/places/domain/entities/place_entity.dart';
import 'package:maps_challenge/app/core/errors/errors.dart';
import 'package:maps_challenge/app/features/places/domain/errors/erros.dart';

import 'package:maps_challenge/app/features/places/domain/repositories/places_repository.dart';
import 'package:maps_challenge/app/features/places/infra/datasources/places_datasource.dart';
import 'package:maps_challenge/app/features/places/infra/exception/exceptions.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  final PlacesDatasource placesDatasource;

  PlacesRepositoryImpl({required this.placesDatasource});

  @override
  Future<Either<Failure, List<PlaceEntity>>> searchPlace({
    required String input,
    required double currentLatitude,
    required double currentLongitude,
  }) async {
    try {
      final result = await placesDatasource.searchPlace(
        input: input,
        currentLatitude: currentLatitude,
        currentLongitude: currentLongitude,
      );
      return Right(result);
    } on RestClientException catch (e) {
      return Left(SearchError(message: e.message));
    } on PlacesAPIException catch (e) {
      return Left(SearchError(message: e.status));
    }
  }

  @override
  Future<Either<Failure, DetailedPlaceEntity>> getPlaceDetails(
      {required String placeId}) async {
    try {
      final result = await placesDatasource.getPlaceDetails(placeId: placeId);
      return Right(result);
    } on RestClientException catch (e) {
      return Left(PlaceDetailsError(message: e.message));
    } on PlacesAPIException catch (e) {
      return Left(PlaceDetailsError(message: e.status));
    }
  }
}
