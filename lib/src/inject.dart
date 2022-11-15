import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../config/config.dart';
import 'infrastucture/todo/todo_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: "http://${config.dioConfig.host}:${config.dioConfig.port}",
        contentType: "application/json",
      ),
    ),
  );
  getIt.registerSingleton<TodoService>(
    TodoService(
      httpClient: getIt<Dio>(),
    ),
  );
}
