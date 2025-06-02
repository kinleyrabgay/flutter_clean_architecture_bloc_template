// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:flutter_clean_architecture_bloc_template/core/di/injection_container.dart'
    as _i815;
import 'package:flutter_clean_architecture_bloc_template/core/network/network_info.dart'
    as _i1003;
import 'package:flutter_clean_architecture_bloc_template/data/datasources/counter_local_data_source.dart'
    as _i1034;
import 'package:flutter_clean_architecture_bloc_template/data/repositories/counter_repository_impl.dart'
    as _i463;
import 'package:flutter_clean_architecture_bloc_template/domain/repositories/auth_repository.dart'
    as _i186;
import 'package:flutter_clean_architecture_bloc_template/domain/repositories/counter_repository.dart'
    as _i620;
import 'package:flutter_clean_architecture_bloc_template/domain/usecases/auth/sign_in.dart'
    as _i945;
import 'package:flutter_clean_architecture_bloc_template/domain/usecases/counter/decrement_counter.dart'
    as _i372;
import 'package:flutter_clean_architecture_bloc_template/domain/usecases/counter/get_counter.dart'
    as _i803;
import 'package:flutter_clean_architecture_bloc_template/domain/usecases/counter/increment_counter.dart'
    as _i832;
import 'package:flutter_clean_architecture_bloc_template/presentation/bloc/counter/counter_bloc.dart'
    as _i597;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.factory<_i1003.NetworkInfo>(
      () => registerModule.networkInfo(gh<_i895.Connectivity>()),
    );
    gh.factory<_i945.SignIn>(() => _i945.SignIn(gh<_i186.AuthRepository>()));
    gh.factory<_i1034.CounterLocalDataSource>(
      () => _i1034.CounterLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i620.CounterRepository>(
      () => _i463.CounterRepositoryImpl(gh<_i1034.CounterLocalDataSource>()),
    );
    gh.factory<_i832.IncrementCounter>(
      () => _i832.IncrementCounter(gh<_i620.CounterRepository>()),
    );
    gh.factory<_i803.GetCounter>(
      () => _i803.GetCounter(gh<_i620.CounterRepository>()),
    );
    gh.factory<_i372.DecrementCounter>(
      () => _i372.DecrementCounter(gh<_i620.CounterRepository>()),
    );
    gh.factory<_i597.CounterBloc>(
      () => _i597.CounterBloc(
        gh<_i803.GetCounter>(),
        gh<_i832.IncrementCounter>(),
        gh<_i372.DecrementCounter>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i815.RegisterModule {}
