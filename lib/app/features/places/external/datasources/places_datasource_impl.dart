import 'package:maps_challenge/app/core/rest_client/rest_client.dart';
import 'package:maps_challenge/app/features/places/domain/entities/detailed_place_entity.dart';
import 'package:maps_challenge/app/features/places/domain/entities/place_entity.dart';
import 'package:maps_challenge/app/features/places/infra/datasources/places_datasource.dart';
import 'package:maps_challenge/app/features/places/infra/exception/exceptions.dart';
import 'package:maps_challenge/app/features/places/infra/models/detailed_place_model.dart';
import 'package:maps_challenge/app/features/places/infra/models/place_model.dart';

class PlacesDatasourceImpl implements PlacesDatasource {
  final RestClient restClient;

  PlacesDatasourceImpl({required this.restClient});

  @override
  Future<List<PlaceEntity>> searchPlace({
    required String input,
    required double currentLatitude,
    required double currentLongitude,
  }) async {
    final result = await restClient.auth().get(
      "/maps/api/place/nearbysearch/json",
      queryParameters: {
        "location": "$currentLatitude,$currentLongitude",
        "keyword": input,
        "type": "establishment",
        "rankby": "distance"
      },
    );
    final String status = result.data["status"];
    if (status == "OK") {
      final places = result.data["results"] as List;
      return places.map((e) => PlacesModel.fromMap(e)).toList();
    } else if (status == "ZERO_RESULTS ") {
      return [];
    } else {
      throw PlacesAPIException(status);
    }
  }

  @override
  Future<DetailedPlaceEntity> getPlaceDetails({required String placeId}) async {
    final result = await restClient.auth().get(
      "/maps/api/place/details/json",
      queryParameters: {
        "place_id": placeId,
        "fields":
            "place_id,geometry,name,formatted_address,photo,formatted_phone_number"
      },
    );
    final String status = result.data["status"];
    if (status == "OK") {
      return DetailedPlaceModel.fromMap(result.data["result"]);
    } else {
      throw PlacesAPIException(status);
    }
  }
}
