import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../network/network_info.dart';

import 'injection_container.config.dart';

/// Global service locator instance
final GetIt getIt = GetIt.instance;

/// Initialize dependency injection
/// This should be called before runApp()
@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

/// Register external dependencies that cannot be handled by injectable
@module
abstract class RegisterModule {
  /// Register SharedPreferences as a singleton
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  /// Register Connectivity as a singleton
  @singleton
  Connectivity get connectivity => Connectivity();

  /// Register NetworkInfo implementation
  @Injectable(as: NetworkInfo)
  NetworkInfoImpl networkInfo(Connectivity connectivity) =>
      NetworkInfoImpl(connectivity);
}
