import 'package:flutter/material.dart';
import 'package:todoapp/page/home_page.dart';

import '../FireBase/auth_methods.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool isLoading = false;

  // Dispose Controlleurs

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  // Login User

  void logginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: emailcontroller.text, password: passwordcontroller.text);
    if (res == 'ok') {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res)));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (route) => false);

        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res)));
      }
    }
  }

  // Widget Tree

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        padding:const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                  'Welcome To TodoApp',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
            const SizedBox(height: 20,),
            const Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                ),
                radius: 40,
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: emailcontroller,
              decoration: InputDecoration(
                  hintText: 'enter your email address',
                  border: OutlineInputBorder(
                      borderSide: Divider.createBorderSide(context)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: Divider.createBorderSide(context)),
                  filled: true,
                  contentPadding: const EdgeInsets.all(8)),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: passwordcontroller,
              decoration: InputDecoration(
                  hintText: 'enter your password',
                  border: OutlineInputBorder(
                      borderSide: Divider.createBorderSide(context)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: Divider.createBorderSide(context)),
                  filled: true,
                  contentPadding: const EdgeInsets.all(8)),
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: ElevatedButton(
                          onPressed: logginUser,
                          child: const Text('Login Now'),
                        ),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
