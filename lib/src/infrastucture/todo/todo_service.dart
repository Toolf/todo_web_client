import 'package:dio/dio.dart';
import 'package:todo_web_client/src/domain/todo/todo_create.dart';
import 'package:todo_web_client/src/domain/todo/todo_update.dart';
import 'package:todo_web_client/src/schema/todo/todo_create.dart';
import 'package:todo_web_client/src/schema/todo/todo_update.dart';

import '../../../core/infrastructure/crudl_service.dart';
import '../../domain/todo/todo.dart';
import '../../schema/todo/todo.dart';

class TodoService extends CrudlService<Todo, TodoCreate, TodoUpdate> {
  TodoService({
    required Dio httpClient,
  }) : super(
          entitySchema: todoSchema,
          entityCreateSchema: todoCreateSchema,
          entityUpdateSchema: todoUpdateSchema,
          httpClient: httpClient,
        );
}
