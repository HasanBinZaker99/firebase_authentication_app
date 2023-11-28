import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: " AIzaSyBoIQhAx0yWyCO64Z7LhUBAkbmMf6VbFaY ",
      appId: "XXX",
      messagingSenderId: "XXX",
      projectId: "XXX",
    ),
  );
  runApp(AuthApp());
}

class AuthApp extends StatefulWidget {
  AuthApp({super.key});

  @override
  State<AuthApp> createState() => _AuthAppState();
}

class _AuthAppState extends State<AuthApp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: Text(
            'Auth User (Logged ' + (user == null ? 'Out' : 'in') + ')',
          )),
          body: Center(
            child: Column(children: [
              TextField(controller: emailController),
              TextField(
                controller: passwordController,
                obscureText: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        setState(() {});
                      },
                      child: Text("Sign Up")),
                  ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                        setState(() {});
                      },
                      child: Text("Sign In")),
                  ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        setState(() {});
                      },
                      child: Text("Log Out")),
                ],
              )
            ]),
          )),
    );
  }
}
