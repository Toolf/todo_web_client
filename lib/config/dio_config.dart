class DioConfig {
  final String host;
  final int port;

  DioConfig({
    required this.host,
    required this.port,
  });
}

final defaultDioConfig = DioConfig(
  host: "localhost",
  port: 8080,
);
