import 'package:maps_challenge/app/core/errors/errors.dart';

class SearchError extends Failure {
  @override
  final String? message;
  SearchError({
    this.message,
  });
}

class PlaceDetailsError extends Failure {
  @override
  final String? message;
  PlaceDetailsError({
    this.message,
  });
}
