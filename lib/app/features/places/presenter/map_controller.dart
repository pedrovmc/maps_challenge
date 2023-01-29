import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_challenge/app/features/places/domain/entities/place_entity.dart';
import 'package:maps_challenge/app/features/places/domain/usecases/search_places_usecase.dart';
import 'package:maps_challenge/app/features/places/presenter/states/search_places_state.dart';
import 'package:maps_challenge/app/features/places/presenter/widgets/place_info_dialog_widget.dart';

class MapController {
  final SearchPlacesUsecase searchPlacesUsecase;

  final searchPlacesState = ValueNotifier<SearchPlacesState>(
    const SearchPlacesInitialState(),
  );

  MapController({
    required this.searchPlacesUsecase,
  });

  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();

  Future<void> searchPlaces(
      String input, double currentLatitude, double currentLongitude) async {
    searchPlacesState.value = const SearchPlacesLoadingState();

    final result = await searchPlacesUsecase(
      input: input,
      currentLatitude: currentLatitude,
      currentLongitude: currentLongitude,
    );

    result.fold((error) {
      searchPlacesState.value = SearchPlacesErrorState(error);
    }, (places) {
      searchPlacesState.value = SearchPlacesSuccessState(places);
    });
  }

  Future<void> goToMarker(Marker marker) async {
    final GoogleMapController controller = await googleMapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: marker.position,
          zoom: 14,
        ),
      ),
    );
  }

  void showErrorSnackbar(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong. Please try again later.")));
    });
  }

  Set<Marker> placesToMarkers(List<PlaceEntity> places, BuildContext context) {
    final Map<String, Marker> markers = {};

    if (places.isEmpty) return {};

    for (var place in places) {
      markers[place.id] = Marker(
        onTap: () async {
          showDialog(
            context: context,
            barrierColor: Colors.transparent,
            builder: (context) {
              return PlaceInfoDialog(
                place: place,
              );
            },
          );
        },
        markerId: MarkerId(place.id),
        position: LatLng(
          place.latitude,
          place.longitude,
        ),
      );
    }
    return markers.values.toSet();
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    if (!googleMapController.isCompleted) {
      googleMapController.complete(controller);
    }
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;

    LatLng location = LatLng(lat, long);
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 14)));
  }
}
