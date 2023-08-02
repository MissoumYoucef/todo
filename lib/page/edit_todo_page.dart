import 'package:flutter/material.dart';

import '../FireBase/firestore_methods.dart';
import '../widgets/todo_form_widget.dart';

class EditTodoPage extends StatefulWidget {
  final String todoId;
  const EditTodoPage({super.key, required this.todoId});

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Edit Todo'),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {},
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: TodoFormWidget(
              title: title,
              description: description,
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onSavedTodo: saveTodo,
            ),
          ),
        ),
      );

  // upload todo item

  void saveTodo() async {
    String res = 'not filled';
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res)));
      }
      return;
    } else {
      try {
        res = await FireStoreMethods()
            .updateTodo(widget.todoId, title, description);
      } catch (err) {
        res = 'error';
      }
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res)));
      }
    }
  }
}
