
import 'package:flutter/material.dart';
import 'package:todoapp/widgets/completed_list_widget.dart';

import '../FireBase/auth_methods.dart';
import '../widgets/add_todo_dialog_widget.dart';
import '../widgets/todo_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const TodoListWidget(),
      const CompletedListWidget(),
    ];
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              shape: BoxShape.rectangle,
              color: Colors.white
            ),
            child: Row(
              children: [
                const Text(
                  'TodoApp',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const Spacer(),
                const Text(
                  'Sign out',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                ),
                IconButton(
                  onPressed: () async {
                    await AuthMethods().signOut();
                  },
                  icon: const Icon(Icons.arrow_left_sharp),
                )
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.75,child: tabs[selectedIndex],)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white.withOpacity(0.7),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined), label: 'Todos'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.done,
                size: 28,
              ),
              label: 'Completed'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.black,
        onPressed: () => showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const AddToDoDialogWidget();
          },
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
