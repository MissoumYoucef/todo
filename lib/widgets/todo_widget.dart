import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../FireBase/firestore_methods.dart';
import '../page/edit_todo_page.dart';

class TodoWidget extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> snap;
  const TodoWidget({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),

      // create slidable widget

      child: Slidable(
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // A pane can dismiss the Slidable.
            dismissible: DismissiblePane(onDismissed: () {
              deleteTodo(context, snap['id']);
            }),

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                onPressed: (_) {
                  deleteTodo(context, snap['id']);
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),

          // The end action pane is the one at the right or the bottom side.
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  editTodo(context, snap['id']);
                },
                backgroundColor: const Color(0xFF0392CF),
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
              ),
            ],
          ),
          key: Key(snap['id']),
          child: builTodo(context)),
    );
  }

  Widget builTodo(BuildContext context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Checkbox(
              activeColor: Theme.of(context).primaryColor,
              checkColor: Colors.pink,
              value: snap['isDone'],
              onChanged: (_) {
                makeTodoCompleted(context, snap['id'], !snap['isDone']);
              },
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snap['title'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22),
                  ),
                  if (snap['description'].isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: Text(
                        snap['description'],
                        style: TextStyle(
                            height: 1.5,
                            color: Theme.of(context).primaryColor,
                            fontSize: 20),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      );

  // Deleting todo Item

  void deleteTodo(BuildContext context, String todoId) async {
    String res = '';
    try {
      res = await FireStoreMethods().deleteTodo(todoId);
    } catch (err) {
      res = 'wrong error';
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res)),
      );
    }
  }

  // Editing todo Item

  void editTodo(BuildContext context, String todoId) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTodoPage(todoId: todoId),
        ),
      );

  //Add todo to Completed listWidget

  void makeTodoCompleted(
      BuildContext context, String todoId, bool isDone) async {
    String res = '';
    try {
      res = await FireStoreMethods().updateIsDoneTodo(todoId, isDone);
    } catch (err) {
      res = 'wrong error';
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res)),
      );
    }
  }
}
