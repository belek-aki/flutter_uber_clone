import 'package:flutter/material.dart';
import 'package:uber_rider_app/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static const idScreen = "register";

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

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
                      height: 290,
                      width: 250,
                      alignment: Alignment.center)),
              const Text('Registration  as a Rider',
                  style: TextStyle(fontSize: 24, fontFamily: "Brand Bold")),
              const SizedBox(height: 2),
              TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(fontSize: 14),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  style: const TextStyle(fontSize: 14)),
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
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Phone",
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
                  if (nameController.text.length < 3) {
                    displayToastMessage(
                        "Name must be atleast 3 characters", context);
                  } else if (!emailController.text.contains("@")) {
                    displayToastMessage("Email address is not Valid", context);
                  } else if (phoneController.text.isEmpty) {
                    displayToastMessage("Phone number is mandatory", context);
                  } else if (passwordController.text.length < 8) {
                    displayToastMessage(
                        "Password must be atleast 8 Characters", context);
                  } else {
                    registerUser(context);
                  }
                },
                color: Colors.yellow.shade600,
                textColor: Colors.white,
                child: const SizedBox(
                    height: 50,
                    child: Center(
                        child: Text(
                      "Create Account",
                      style: TextStyle(fontSize: 18, fontFamily: "Brand Bold"),
                    ))),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
              ),
              const SizedBox(height: 20),
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginScreen.idScreen, (route) => false);
                  },
                  child: const Text("Already have an Account? Login Here.")),
            ],
          ),
        )),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerUser(BuildContext context) async {
    final User? firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .catchError((errMsg) {
      displayToastMessage("Error" + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) //user create
    {
      //save user
      usersRef.child(firebaseUser.uid);
      Map userDataMap = {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "phone": phoneController.text.trim()
      };
      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage(
          "Congratulations, your account has been created", context);
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.idScreen, (route) => false);
    } else {
      //error
      displayToastMessage("New user account has not been Created", context);
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
