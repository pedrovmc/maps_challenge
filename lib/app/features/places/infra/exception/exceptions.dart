class PlacesAPIException implements Exception {
  final String status;

  PlacesAPIException(this.status);
}
