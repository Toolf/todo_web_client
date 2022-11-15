import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_web_client/src/domain/todo/todo_update.dart';

import '../../application/todo/todo_list_view/todo_list_view_bloc.dart';
import '../../domain/todo/todo.dart';
import '../../infrastucture/todo/todo_service.dart';
import '../../inject.dart';

class TodoListView extends StatelessWidget {
  final TodoListViewBloc bloc = TodoListViewBloc(getIt<TodoService>());

  TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: BlocConsumer<TodoListViewBloc, TodoListViewState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is TodoListViewInitial) {
            bloc.add(TodoListViewFetchEvent());
            return const CircularProgressIndicator();
          } else if (state is TodoListViewLoading) {
            if (state.list == null) {
              return const CircularProgressIndicator();
            }
          }

          if (state.list != null) {
            final todoLists = state.list!;
            return ListView.builder(
              itemCount: todoLists.length,
              itemBuilder: (context, index) {
                return buildTodoList(context, todoLists[index]);
              },
            );
          }
          return const Text("Hmmm");
        },
        listener: (context, state) {
          if (state is TodoListViewError) {
            _errorMessage(context, "Error", state.message);
          }
        },
      )),
    );
  }

  Widget buildTodoList(BuildContext context, Todo todo) {
    return ListTile(
      title: Text(todo.title),
      subtitle: Text(todo.description),
      trailing: Checkbox(
        value: todo.completed,
        onChanged: (bool? value) {
          if (value == null) return;

          bloc.add(
            TodoListViewUpdateItemEvent(
              TodoUpdate(
                todoId: todo.todoId,
                completed: value,
              ),
            ),
          );
        },
      ),
    );
  }

  _errorMessage(BuildContext context, String title, String message) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
