class Todo {
  final int todoId;
  final String title;
  final String description;
  final bool completed;

  Todo(this.todoId, this.title, this.description, this.completed);

  static Todo fromJson(dynamic json) {
    return Todo(
      json['todoId'],
      json['title'],
      json['description'],
      json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todoId': todoId,
      'title': title,
      'description': description,
      'completed': completed,
    };
  }
}
