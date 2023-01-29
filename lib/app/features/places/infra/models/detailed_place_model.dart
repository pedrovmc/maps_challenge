import 'package:maps_challenge/app/features/places/domain/entities/detailed_place_entity.dart';

class DetailedPlaceModel extends DetailedPlaceEntity {
  DetailedPlaceModel({
    required super.id,
    required super.latitude,
    required super.longitude,
    required super.thumbnail,
    required super.address,
    required super.name,
    required super.images,
    required super.phoneNumber,
  });

  factory DetailedPlaceModel.fromMap(Map<String, dynamic> map) {
    final geometry = map["geometry"];

    return DetailedPlaceModel(
      id: map["place_id"],
      latitude: geometry["location"]["lat"],
      longitude: geometry["location"]["lng"],
      thumbnail: (map["photos"] as List?)?.first?["photo_reference"] ?? "",
      address: map["formatted_address"],
      name: map["name"],
      images: (map["photos"] as List?)
              ?.map((e) => e["photo_reference"].toString())
              .toList() ??
          [],
      phoneNumber: map["formatted_phone_number"] ?? "",
    );
  }
}
