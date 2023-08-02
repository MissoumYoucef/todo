import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../FireBase/firestore_methods.dart';
import 'todo_form_widget.dart';

class AddToDoDialogWidget extends StatefulWidget {
  const AddToDoDialogWidget({super.key});

  @override
  State<AddToDoDialogWidget> createState() => _AddToDoDialogWidgetState();
}

class _AddToDoDialogWidgetState extends State<AddToDoDialogWidget> {
  final formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: formKey,
        child: Column(
          children: [
            const Text(
              'Add ToDo',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(
              height: 8,
            ),
            TodoFormWidget(
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onSavedTodo: addTodo,
            )
          ],
        ),
      ),
    );
  }

  void addTodo() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
        // isLoading = true

        setState(() {
          isLoading = true;
        });

        // res to verify if a project was succefully created in firebase

        String res = '';

        // post todo to Firebase

        await FireStoreMethods()
            .uploadTodo(const Uuid().v1(), title, description, DateTime.now().toString(), false);

        //Verify if post is successfully uploaded

        try{
        if (res == "ok") {
          res = 'ToDo has been uploaded';
        }
        else{
          res = 'faild to upload';
        }
      } catch (err) {
        res = 'error uploading to datbase';
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res)),
      );
        Navigator.of(context).pop();
      }

      // isLoading = false

      setState(() {
        isLoading = false;
      });
    }
  }
}
