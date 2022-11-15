// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_web_client/core/infrastructure/pagination/pagination.dart';

import '../../../domain/todo/todo.dart';
import '../../../domain/todo/todo_update.dart';
import '../../../infrastucture/todo/todo_service.dart';

part 'todo_list_view_event.dart';
part 'todo_list_view_state.dart';

class TodoListViewBloc extends Bloc<TodoViewListEvent, TodoListViewState> {
  final TodoService todoListService;

  TodoListViewBloc(this.todoListService) : super(TodoListViewInitial()) {
    on<TodoListViewFetchEvent>((event, emit) async {
      try {
        emit(TodoListViewLoading(state.list));
        final req = PaginationRequest(filter: "", page: 0, perPage: 100);
        final res = await todoListService.list.method(req);
        emit(TodoListViewLoaded(res.data));
      } catch (e) {
        emit(
          TodoListViewError(
            state.list,
            e.toString(),
          ),
        );
      }
    });
    on<TodoListViewUpdateItemEvent>((event, emit) async {
      try {
        if (state.list == null) return;

        final todoUpdate = event.todoUpdate;
        final res = await todoListService.update.method(todoUpdate);

        final index =
            state.list!.indexWhere((t) => t.todoId == todoUpdate.todoId);
        final newList = <Todo>[...state.list!];
        newList[index] = res;

        emit(TodoListViewUpdateItem(newList));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        emit(
          TodoListViewError(
            state.list,
            "Network error. Please check internet connection.",
          ),
        );
      }
    });
  }
}
