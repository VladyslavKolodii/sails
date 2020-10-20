import 'package:HybridSailmate/app.dart';
import 'package:flutter/material.dart';
import 'package:config_repository/config_repository.dart';

void main() {
  runApp(App(configRepository: ConfigRepository()));
}
