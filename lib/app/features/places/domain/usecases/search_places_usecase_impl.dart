import 'package:dartz/dartz.dart';
import 'package:maps_challenge/app/core/errors/errors.dart';
import 'package:maps_challenge/app/features/places/domain/entities/place_entity.dart';
import 'package:maps_challenge/app/features/places/domain/repositories/places_repository.dart';
import 'package:maps_challenge/app/features/places/domain/usecases/search_places_usecase.dart';

class SearchPlacesUsecaseImpl extends SearchPlacesUsecase {
  final PlacesRepository placesRepository;

  SearchPlacesUsecaseImpl({required this.placesRepository});

  @override
  Future<Either<Failure, List<PlaceEntity>>> call({
    required String input,
    required double currentLatitude,
    required double currentLongitude,
  }) async {
    final result = await placesRepository.searchPlace(
      input: input,
      currentLatitude: currentLatitude,
      currentLongitude: currentLongitude,
    );
    return result;
  }
}
