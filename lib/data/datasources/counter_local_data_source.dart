import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';
import '../../core/constants/app_constants.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/logger.dart';
import '../models/counter_model.dart';

/// Abstract class for counter local data source operations
abstract class CounterLocalDataSource {
  /// Get the cached counter from local storage
  Future<CounterModel> getCachedCounter();

  /// Cache the counter to local storage
  Future<void> cacheCounter(CounterModel counter);

  /// Clear the cached counter
  Future<void> clearCachedCounter();
}

/// Implementation of CounterLocalDataSource using SharedPreferences
@Injectable(as: CounterLocalDataSource)
class CounterLocalDataSourceImpl implements CounterLocalDataSource {
  final SharedPreferences sharedPreferences;

  CounterLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<CounterModel> getCachedCounter() async {
    try {
      final value = sharedPreferences.getInt(AppConstants.counterValueKey);
      if (value != null) {
        AppLogger.debug('Retrieved counter value from cache: $value');
        return CounterModel(value: value, lastUpdated: DateTime.now());
      } else {
        AppLogger.debug('No counter value found in cache, returning default');
        return const CounterModel(value: 0);
      }
    } catch (e) {
      AppLogger.error('Error getting cached counter', e);
      throw const CacheException('Failed to get cached counter');
    }
  }

  @override
  Future<void> cacheCounter(CounterModel counter) async {
    try {
      await sharedPreferences.setInt(
        AppConstants.counterValueKey,
        counter.value,
      );
      AppLogger.debug('Cached counter value: ${counter.value}');
    } catch (e) {
      AppLogger.error('Error caching counter', e);
      throw const CacheException('Failed to cache counter');
    }
  }

  @override
  Future<void> clearCachedCounter() async {
    try {
      await sharedPreferences.remove(AppConstants.counterValueKey);
      AppLogger.debug('Cleared cached counter');
    } catch (e) {
      AppLogger.error('Error clearing cached counter', e);
      throw const CacheException('Failed to clear cached counter');
    }
  }
}
