import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_challenge/app/features/places/presenter/map_controller.dart';
import 'package:maps_challenge/app/features/places/presenter/states/search_places_state.dart';
import 'package:maps_challenge/app/features/places/presenter/widgets/search_bar_widget.dart';

class MapPage extends StatefulWidget {
  final MapController mapController;
  const MapPage({Key? key, required this.mapController}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );

  final _searchBarController = TextEditingController();

  double currentLatitude = _kGooglePlex.target.latitude;
  double currentLongitude = _kGooglePlex.target.longitude;
  final Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: widget.mapController.searchPlacesState,
        builder: (context, state, _) {
          if (state is SearchPlacesSuccessState) {
            markers.clear();
            markers.addAll(
                widget.mapController.placesToMarkers(state.places, context));
            widget.mapController.goToMarker(
              markers.first,
            );
          }
          if (state is SearchPlacesErrorState) {
            widget.mapController.showErrorSnackbar(context);
          }
          return Stack(
            children: [
              GoogleMap(
                markers: markers,
                onCameraMove: (position) {
                  currentLatitude = position.target.latitude;
                  currentLongitude = position.target.longitude;
                },
                initialCameraPosition: _kGooglePlex,
                onMapCreated: widget.mapController.onMapCreated,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 64),
                child: SearchBarWidget(
                  isLoading: state is SearchPlacesLoadingState,
                  searchController: _searchBarController,
                  callback: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    widget.mapController.searchPlaces(
                      _searchBarController.text,
                      currentLatitude,
                      currentLongitude,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
