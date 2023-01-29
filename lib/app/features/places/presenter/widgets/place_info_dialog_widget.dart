import 'package:flutter/material.dart';
import 'package:maps_challenge/app/core/consts.dart';
import 'package:maps_challenge/app/features/places/domain/entities/place_entity.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_challenge/app/routes.dart';

class PlaceInfoDialog extends StatelessWidget {
  final PlaceEntity place;

  const PlaceInfoDialog({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 330),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                getImage(),
                const SizedBox(height: 8),
                Text(place.name,
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Text(place.address),
                TextButton(
                  onPressed: () {
                    context.pushNamed(
                      Routes.details.name,
                      extra: place,
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text(
                    "View place details",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Image getImage() {
    return Image.network(
      "$baseUrl/maps/api/place/photo?photo_reference=${place.thumbnail}&maxheight=100&key=$apiKey",
      errorBuilder: (context, error, stackTrace) {
        return Text(
          "Image unavailable",
          style: TextStyle(color: Colors.grey.shade500),
        );
      },
    );
  }
}
