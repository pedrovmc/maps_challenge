import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_challenge/app/features/places/domain/entities/place_entity.dart';
import 'package:maps_challenge/app/features/places/presenter/map_page.dart';
import 'package:maps_challenge/app/features/places/presenter/place_details_page.dart';
import 'package:maps_challenge/app/routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: Routes.map.path,
            name: Routes.map.name,
            builder: (context, state) => MapPage(
              mapController: GetIt.I.get(),
            ),
            routes: [
              GoRoute(
                path: Routes.details.name,
                name: Routes.details.name,
                builder: (context, state) {
                  return PlaceDetailsPage(
                    placeEntity: state.extra as PlaceEntity,
                    placeDetailsController: GetIt.I.get(),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
