import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../model/todo.dart';

class FireStoreMethods{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //add todo Item from firbase database


  Future<String> uploadTodo(
    String id,
    String title,
    String description,
    String createdTime,
    bool isDone
  ) async {
    String res = 'error';
    try {
      String todoId = const Uuid().v1();

      Todo todo = Todo(
          id: todoId,
          title: title,
          description: description,
          createdTime: createdTime,
          isDone: isDone);

      _firestore.collection('todos').doc(todoId).set(todo.toJson());

      res = 'ok';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //delete todo Item from firbase database

  Future<String> deleteTodo(
    String todoId
  ) async {
    String res = 'error';
    try {

      await _firestore.collection('todos').doc(todoId).delete();

      res = 'deleted suucefully';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //upload todo Item to firbase database

  Future<String> updateTodo(
    String todoId,
    String todoTitle,
    String todoDescription,
  ) async {
    String res = 'error';
    try {

      await _firestore.collection('todos').doc(todoId).update(
        {
          'title':todoTitle,
          'description':todoDescription,
        }
      );

      res = 'updated suucefully';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //change isdone attribute of todo Item from firbase database

  Future<String> updateIsDoneTodo(
    String todoId,
    bool isDone,
  ) async {
    String res = 'error';
    try {

      await _firestore.collection('todos').doc(todoId).update(
        {
          'isDone':isDone,
        }
      );

      res = 'updated suucefully';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }


}