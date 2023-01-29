import 'package:dartz/dartz.dart';
import 'package:maps_challenge/app/core/errors/errors.dart';
import 'package:maps_challenge/app/features/places/domain/entities/detailed_place_entity.dart';
import 'package:maps_challenge/app/features/places/domain/repositories/places_repository.dart';
import 'package:maps_challenge/app/features/places/domain/usecases/get_place_details_usecase.dart';

class GetPlaceDetailsUsecaseImpl extends GetPlaceDetailsUsecase {
  final PlacesRepository placesRepository;

  GetPlaceDetailsUsecaseImpl({required this.placesRepository});

  @override
  Future<Either<Failure, DetailedPlaceEntity>> call(
      {required String placeId}) async {
    final result = await placesRepository.getPlaceDetails(placeId: placeId);
    return result;
  }
}
