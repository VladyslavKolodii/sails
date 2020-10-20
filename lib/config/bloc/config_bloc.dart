import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:config_repository/config_repository.dart';

class ConfigBloc extends Cubit<MapConfig> {
  ConfigBloc({
    @required ConfigRepository configRepository,
  }) : _configRepository = configRepository,
  super(null);

  final ConfigRepository _configRepository;

  Future<void> init() async {
    MapConfig config = await _configRepository.getMapboxConfig();
    emit(config);
  }
}
