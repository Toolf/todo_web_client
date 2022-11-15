import 'package:flutter/material.dart';

import 'presentation/todo/todo_list_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TodoListView();
  }
}
