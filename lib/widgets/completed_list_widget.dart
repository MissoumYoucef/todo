import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/widgets/todo_widget.dart';

class CompletedListWidget extends StatelessWidget {
  const CompletedListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    


    return Scaffold(
      
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('todos').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (context, index) => Container(
              height: 8,
            ),
            itemBuilder: (context, index) {
              final todo = snapshot.data!.docs[index];
              final isDone = todo['isDone'];       
              if (isDone) {
                return TodoWidget(snap: todo);
              } else {
                // Return an empty container if todo['isDone'] is false.
                return Container();
              }
            },
          );
        },
      ),
    );
  }


}
