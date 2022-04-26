import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: const [
              SizedBox(height: 45),
              Center(
                child: Image(
                  image: AssetImage("images/logo.png"),
                  height: 250,
                  width: 250,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Login as a Rider',
                style: TextStyle(fontSize: 24, fontFamily: "Brand Bold"),
              ),
              SizedBox(height: 2),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(fontSize: 14),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                ),
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 2),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(fontSize: 14),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                ),
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
