import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String id;
  String title;
  String description;
  String createdTime;
  bool isDone;

  Todo({required this.id,
    required this.title,
    this.description='',
    required this.createdTime,
    this.isDone=false
  });


   static Todo fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Todo(
      id: snapshot['id'],
      title: snapshot['title'],
      description: snapshot['description'],
      createdTime: snapshot['createdTime'],
      isDone: snapshot['isDone'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'createdTime': createdTime,
        'isDone': isDone,
      };
  
}
