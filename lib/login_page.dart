import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/ProductInfo.dart';
import 'package:flutter_application_2/my_text_field.dart';
import 'package:flutter_application_2/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final String _userName;
  late final String _uID;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  void signIn() async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )
        .then((userCredential) {
      final User? user = userCredential.user;
      _uID = userCredential.user!.uid;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${user?.email} signed in'),
        ),
      );
      firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': _emailController.text,
      }, SetOptions(merge: true));

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductInfo(
                    userID: userCredential.user!.uid,
                    userName: '',
                  )));
    }).catchError((error) {
      // Print the error message to the console for debugging
      print('Error signing in: $error');

      // Show the error message in a snackbar
      String errorMessage = 'Failed to sign in';
      if (error is FirebaseAuthException) {
        errorMessage = error.message ?? 'Failed to sign in';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    });
  }

  void getUserName() async {
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uID).get();
    _userName = userDoc.get(_emailController.text as String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Icon(
                Icons.message,
                size: 100,
                color: Colors.grey[800],
              ),
              const Text(
                "Welcome back you've been missed!",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: _emailController,
                hintText: "Email",
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: _passwordController,
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: signIn,
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(
                          255, 232, 130, 248)), // Set button color to pink
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30), // Adjust padding
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not a member?"),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                      "Register now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration:
                            TextDecoration.underline, // Underline effect
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
