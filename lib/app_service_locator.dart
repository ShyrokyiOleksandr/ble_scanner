import 'package:ble_scanner/data/data_sources/ble_remote_data_source.dart';
import 'package:ble_scanner/data/repositories/ble_repository_impl.dart';
import 'package:ble_scanner/domain/repositories/ble_repository.dart';
import 'package:ble_scanner/domain/use_cases/connect_to_device.dart';
import 'package:ble_scanner/domain/use_cases/discover_services.dart';
import 'package:ble_scanner/domain/use_cases/scan_for_devices.dart';
import 'package:ble_scanner/presentation/features/ble/bloc/ble_cubit.dart';
import 'package:get_it/get_it.dart';

class AppServiceLocator {
  static void setup() {
    // data sources
    GetIt.I.registerLazySingleton<BLERemoteDataSource>(() => BLERemoteDataSourceImpl());

    // repositories
    GetIt.I.registerLazySingleton<BLERepository>(
      () => BLERepositoryImpl(
        remoteDataSource: GetIt.I<BLERemoteDataSource>(),
      ),
    );

    // use cases
    GetIt.I.registerLazySingleton(() => ScanForDevices(GetIt.I<BLERepository>()));
    GetIt.I.registerLazySingleton(() => ConnectToDevice(GetIt.I<BLERepository>()));
    GetIt.I.registerLazySingleton(() => DiscoverServices(GetIt.I<BLERepository>()));

    // blocs
    GetIt.I.registerFactory(
      () => BLECubit(
        scanForDevices: GetIt.I<ScanForDevices>(),
        connectToDevice: GetIt.I<ConnectToDevice>(),
        discoverServices: GetIt.I<DiscoverServices>(),
      ),
    );
  }
}
