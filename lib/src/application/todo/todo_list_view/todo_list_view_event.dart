part of 'todo_list_view_bloc.dart';

@immutable
abstract class TodoViewListEvent {}

@immutable
class TodoListViewInitializeEvent extends TodoViewListEvent {}

@immutable
class TodoListViewFetchEvent extends TodoViewListEvent {}

@immutable
class TodoListViewUpdateItemEvent extends TodoViewListEvent {
  final TodoUpdate todoUpdate;

  TodoListViewUpdateItemEvent(this.todoUpdate);
}
