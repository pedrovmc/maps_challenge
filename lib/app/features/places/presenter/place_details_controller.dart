import 'package:flutter/material.dart';
import 'package:maps_challenge/app/core/consts.dart';
import 'package:maps_challenge/app/features/places/domain/usecases/get_place_details_usecase.dart';
import 'package:maps_challenge/app/features/places/presenter/states/place_details_state.dart';

class PlaceDetailsController {
  final GetPlaceDetailsUsecase getPlaceDetailsUsecase;

  PlaceDetailsController({required this.getPlaceDetailsUsecase});

  final placeDetailsState =
      ValueNotifier<PlaceDetailsState>(const PlaceDetailsInitialState());

  Future<void> getPlaceDetails(String placeId) async {
    placeDetailsState.value = const PlaceDetailsLoadingState();
    final result = await getPlaceDetailsUsecase(placeId: placeId);
    result.fold(
      (l) {
        placeDetailsState.value = PlaceDetailsErrorState(l);
      },
      (r) {
        placeDetailsState.value = PlaceDetailsSuccessState(r);
      },
    );
  }

  List<Image> getImages(List<String> images) {
    return images.map((e) {
      return Image.network(
        "$baseUrl/maps/api/place/photo?photo_reference=$e&maxheight=500&key=$apiKey",
        errorBuilder: (context, error, stackTrace) {
          return Text(
            "Image unavailable",
            style: TextStyle(color: Colors.grey.shade500),
          );
        },
      );
    }).toList();
  }

  void showErrorSnackbar(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong. Please try again later.")));
    });
  }
}
