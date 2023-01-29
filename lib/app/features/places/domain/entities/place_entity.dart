abstract class PlaceEntity {
  final String id;
  final String name;
  final String thumbnail;
  final String address;
  final double latitude;
  final double longitude;

  PlaceEntity({
    required this.id,
    required this.thumbnail,
    required this.address,
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}
