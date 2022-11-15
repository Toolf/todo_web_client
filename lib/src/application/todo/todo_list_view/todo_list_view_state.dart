part of 'todo_list_view_bloc.dart';

@immutable
abstract class TodoListViewState {
  final List<Todo>? list;

  const TodoListViewState(this.list);
}

@immutable
class TodoListViewInitial extends TodoListViewState {
  TodoListViewInitial() : super(null);
}

@immutable
class TodoListViewLoading extends TodoListViewState {
  TodoListViewLoading(super.list);
}

@immutable
class TodoListViewLoaded extends TodoListViewState {
  TodoListViewLoaded(super.list);
}

@immutable
class TodoListViewUpdateItem extends TodoListViewState {
  TodoListViewUpdateItem(super.list);
}

@immutable
class TodoListViewError extends TodoListViewState {
  final String message;

  TodoListViewError(super.list, this.message);
}
