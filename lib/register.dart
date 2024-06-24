// import 'dart:js_util';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/ProductInfo.dart';
import 'package:flutter_application_2/login_page.dart';
import 'package:flutter_application_2/my_text_field.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});


  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  void signUp() async {
  // Check if passwords match
  if (passwordController.text != confirmPasswordController.text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Passwords do not match'),
      ),
    );
    return; // Exit the method early
  }
  try {
    // Create user with email and password
    final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    firestore.collection('users').doc(userCredential.user!.uid).set({
      'uid' : userCredential.user!.uid,
      'userName' : userNameController.text,
      'email': emailController.text,
    });
    final User? user = userCredential.user;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${user?.email} registered'),
      ),
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductInfo(userID: userCredential.user!.uid,userName: userNameController.text,)));
  } catch (e) {
    // Print the error message to the console for debugging
    print('Error registering user: $e');

    // Show the error message in a snackbar
    String errorMessage = 'Failed to register';
    if (e is FirebaseAuthException) {
      if (e.code == 'email-already-in-use') {
        errorMessage = 'Email already in use';
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
      ),
    );
  }
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
              const SizedBox(height:50),
              Icon(
                Icons.message,
                size:100,
                color: Colors.grey[800],
              ),
              const Text(
                "Let\'s create an account for you!",
                style:TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: userNameController, 
                hintText: "UserName", 
                obscureText: false
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: emailController, 
                hintText: "Email", 
                obscureText: false
              ),
              const SizedBox(height:10),
              MyTextField(
                controller: passwordController, 
                hintText: "Password", 
                obscureText: true,
              ),
                const SizedBox(height:10),
                MyTextField(
                controller: confirmPasswordController, 
                hintText: "Confirm password", 
                obscureText: true,
              ),
              const SizedBox(height:25),
              ElevatedButton(
                onPressed: signUp,
                child: Text(
                  "Register",
                  style:TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 232, 130, 248)), // Set button color to pink
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Adjust padding
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                ),
              ),
                const SizedBox(height:50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("You have an account?"),
                    SizedBox(width:4),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                      },
                      child:const Text(
                        "Login now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                      )
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