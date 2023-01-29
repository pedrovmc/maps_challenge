import 'package:maps_challenge/app/features/places/domain/entities/place_entity.dart';

class PlacesModel extends PlaceEntity {
  PlacesModel({
    required super.id,
    required super.address,
    required super.name,
    required super.thumbnail,
    required super.latitude,
    required super.longitude,
  });

  factory PlacesModel.fromMap(Map<String, dynamic> map) {
    final geometry = map["geometry"];

    return PlacesModel(
      id: map["place_id"],
      address: map["vicinity"] ?? "",
      name: map["name"],
      thumbnail: (map["photos"] as List?)?.first?["photo_reference"] ?? "",
      latitude: geometry["location"]["lat"],
      longitude: geometry["location"]["lng"],
    );
  }
}
