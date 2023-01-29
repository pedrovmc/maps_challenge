import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:maps_challenge/app/features/places/domain/entities/place_entity.dart';
import 'package:maps_challenge/app/features/places/presenter/place_details_controller.dart';
import 'package:maps_challenge/app/features/places/presenter/states/place_details_state.dart';

class PlaceDetailsPage extends StatefulWidget {
  final PlaceEntity placeEntity;
  final PlaceDetailsController placeDetailsController;
  const PlaceDetailsPage({
    Key? key,
    required this.placeEntity,
    required this.placeDetailsController,
  }) : super(key: key);

  @override
  State<PlaceDetailsPage> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  @override
  void initState() {
    widget.placeDetailsController.getPlaceDetails(widget.placeEntity.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.placeDetailsController.placeDetailsState,
      builder: (context, state, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            elevation: 0.0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              "Place Details",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Builder(
            builder: (context) {
              if (state is PlaceDetailsSuccessState) {
                final detailedPlace = state.detailedPlaceEntity;
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    detailedPlace.images.isNotEmpty
                        ? CarouselSlider(
                            options: CarouselOptions(
                              height: 300.0,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 5),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              enlargeCenterPage: true,
                            ),
                            items: widget.placeDetailsController
                                .getImages(detailedPlace.images),
                          )
                        : const SizedBox(
                            height: 64,
                          ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detailedPlace.name,
                            style: const TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            detailedPlace.address,
                            style: const TextStyle(
                              fontSize: 22.0,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            detailedPlace.phoneNumber,
                            style: const TextStyle(
                              fontSize: 22.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                if (state is PlaceDetailsErrorState) {
                  widget.placeDetailsController.showErrorSnackbar(context);
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      },
    );
  }
}
