import 'package:maps_challenge/app/features/places/domain/entities/place_entity.dart';

abstract class DetailedPlaceEntity extends PlaceEntity {
  final List<String> images;
  final String phoneNumber;

  DetailedPlaceEntity({
    required super.id,
    required super.latitude,
    required super.longitude,
    required super.thumbnail,
    required super.address,
    required super.name,
    required this.images,
    required this.phoneNumber,
  });
}
