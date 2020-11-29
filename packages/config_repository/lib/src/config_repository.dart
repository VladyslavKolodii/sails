import 'dart:async';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'models/models.dart';

class ConfigRepository {
  RemoteConfig _config;

  Future<void> _init() async {
    _config = await RemoteConfig.instance;
    try {
      await _fetchAndActivate();
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print('Remote config fetch throttled: $exception');
    // ignore: avoid_catches_without_on_clauses
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
  }

  Future<void> _fetchAndActivate() async {
    await _config.fetch(expiration: const Duration(seconds: 60));
    await _config.activateFetched();
  }

  Future<MapConfig> getMapboxConfig() async {
    if (_config == null) {
      await _init();
    }

    final String apiKey = _config.getString('mapbox_api_key');
    final String styleString = _config.getString('mapbox_style_string');

    return MapConfig(apiKey, styleString);
  }
}
