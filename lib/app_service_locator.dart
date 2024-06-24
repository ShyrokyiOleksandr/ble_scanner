import 'package:ble_scanner/data/data_sources/ble_remote_data_source.dart';
import 'package:ble_scanner/data/repositories/ble_repository_impl.dart';
import 'package:ble_scanner/domain/repositories/ble_repository.dart';
import 'package:ble_scanner/domain/use_cases/connect_to_device_use_case.dart';
import 'package:ble_scanner/domain/use_cases/discover_services_use_case.dart';
import 'package:ble_scanner/domain/use_cases/scan_for_devices_use_case.dart';
import 'package:ble_scanner/presentation/features/ble/bloc/ble_cubit.dart';
import 'package:get_it/get_it.dart';

class AppServiceLocator {
  static Future<void> setup() async {
    // data sources
    GetIt.I.registerLazySingleton<BLERemoteDataSource>(() => BLERemoteDataSourceImpl());

    // repositories
    GetIt.I.registerLazySingleton<BLERepository>(
      () => BLERepositoryImpl(
        remoteDataSource: GetIt.I<BLERemoteDataSource>(),
      ),
    );

    // use cases
    GetIt.I.registerLazySingleton(() => ScanForDevicesUseCase(GetIt.I<BLERepository>()));
    GetIt.I.registerLazySingleton(() => ConnectToDeviceUseCase(GetIt.I<BLERepository>()));
    GetIt.I.registerLazySingleton(() => DiscoverServicesUseCase(GetIt.I<BLERepository>()));

    // blocs
    GetIt.I.registerLazySingleton(
      () => BLECubit(
        scanForDevicesUseCase: GetIt.I<ScanForDevicesUseCase>(),
        connectToDeviceUseCase: GetIt.I<ConnectToDeviceUseCase>(),
        discoverServicesUseCase: GetIt.I<DiscoverServicesUseCase>(),
      ),
    );
  }
}
