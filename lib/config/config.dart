import 'dio_config.dart';

class Config {
  final DioConfig dioConfig;

  Config({
    required this.dioConfig,
  });
}

final config = Config(
  dioConfig: defaultDioConfig,
);
