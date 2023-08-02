import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedTodo;

  const TodoFormWidget(
      {super.key,
      this.title = '',
      this.description = '',
      required this.onChangedTitle,
      required this.onChangedDescription,
      required this.onSavedTodo});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [buildTitle(), buildDescription(), buildButton()],
      ),
    );
  }

  Widget buildTitle() => TextFormField(
      maxLines: 1,
      initialValue: title,
      onChanged: onChangedTitle,
      validator: (title) {
        if (title!.isEmpty) {
          return 'the title cant be empty';
        }
        return null;
      },
      decoration: const InputDecoration(
          border: UnderlineInputBorder(), labelText: 'Title'));

  Widget buildDescription() => TextFormField(
      maxLines: 3,
      initialValue: description,
      onChanged: onChangedDescription,
      validator: (description) {
        if (description!.isEmpty) {
          return 'the description cant be empty';
        }
        return null;
      },
      decoration: const InputDecoration(
          border: UnderlineInputBorder(), labelText: 'Description'));

  Widget buildButton() => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
          onPressed: onSavedTodo,
          child: const Text('Save'),
        ),
  );
}
