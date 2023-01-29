import 'package:get_it/get_it.dart';
import 'package:maps_challenge/app/core/rest_client/dio/dio_rest_client.dart';
import 'package:maps_challenge/app/core/rest_client/rest_client.dart';
import 'package:maps_challenge/app/features/places/domain/repositories/places_repository.dart';
import 'package:maps_challenge/app/features/places/domain/usecases/get_place_details_usecase.dart';
import 'package:maps_challenge/app/features/places/domain/usecases/get_place_details_usecase_impl.dart';
import 'package:maps_challenge/app/features/places/domain/usecases/search_places_usecase.dart';
import 'package:maps_challenge/app/features/places/domain/usecases/search_places_usecase_impl.dart';
import 'package:maps_challenge/app/features/places/external/datasources/places_datasource_impl.dart';
import 'package:maps_challenge/app/features/places/infra/datasources/places_datasource.dart';
import 'package:maps_challenge/app/features/places/infra/repositories/places_repository_impl.dart';
import 'package:maps_challenge/app/features/places/presenter/map_controller.dart';
import 'package:maps_challenge/app/features/places/presenter/place_details_controller.dart';

class Injections {
  static void registerInjections() {
    final getIt = GetIt.instance;
    getIt.registerLazySingleton<RestClient>(() => DioRestClient());

    //Places injections
    getIt.registerLazySingleton<PlacesDatasource>(
        () => PlacesDatasourceImpl(restClient: getIt.get()));
    getIt.registerLazySingleton<PlacesRepository>(
        () => PlacesRepositoryImpl(placesDatasource: getIt.get()));

    //Map injections
    getIt.registerLazySingleton<MapController>(() => MapController(
          searchPlacesUsecase: getIt.get(),
        ));
    getIt.registerLazySingleton<SearchPlacesUsecase>(
        () => SearchPlacesUsecaseImpl(placesRepository: getIt.get()));

    //Details injections
    getIt.registerLazySingleton<GetPlaceDetailsUsecase>(
        () => GetPlaceDetailsUsecaseImpl(placesRepository: getIt.get()));
    getIt.registerLazySingleton<PlaceDetailsController>(
      () => PlaceDetailsController(
        getPlaceDetailsUsecase: getIt.get(),
      ),
    );
  }
}
