import 'package:flutter/material.dart';
import 'package:uber_rider_app/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const idScreen = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 35),
              const Center(
                  child: Image(
                      image: AssetImage("images/logo.png"),
                      height: 390,
                      width: 250,
                      alignment: Alignment.center)),
              const Text('Login as a Rider',
                  style: TextStyle(fontSize: 24, fontFamily: "Brand Bold")),
              const SizedBox(height: 2),
              TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(fontSize: 14),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 2),
              TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 14),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 20),
              RaisedButton(
                onPressed: () {
                  if (!emailController.text.contains("@")) {
                    displayToastMessage("Email address is not Valid", context);
                  } else if (passwordController.text.length < 8) {
                    displayToastMessage("Password is mandatory", context);
                  } else {
                    loginAndAuthUser(context);
                  }
                },
                color: Colors.yellow.shade600,
                textColor: Colors.white,
                child: const SizedBox(
                    height: 50,
                    child: Center(
                        child: Text(
                      "Login",
                      style: TextStyle(fontSize: 18, fontFamily: "Brand Bold"),
                    ))),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
              ),
              const SizedBox(height: 20),
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RegistrationScreen.idScreen, (route) => false);
                  },
                  child: const Text("Do not have an Account? Register Here.")),
            ],
          ),
        )),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthUser(BuildContext context) async {
    final User? firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .catchError((errMsg) {
      displayToastMessage("Error" + errMsg.toString(), context);
    }))
        .user;
    if (firebaseUser != null) {
      usersRef.child(firebaseUser.uid).once().then((value) => (DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.idScreen, (route) => false);
          displayToastMessage("you are logged-in now", context);
        } else {
          _firebaseAuth.signOut();
          displayToastMessage(
              "No record exists for this user. Please create new account",
              context);
        }
      });
    } else {
      //error
      displayToastMessage("Error Occurred, can not build", context);
    }
  }
}
