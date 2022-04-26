import 'package:flutter/material.dart';
import 'screens/screens.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'brand-Regular',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute:  LoginScreen.idScreen,
      routes: {
        RegistrationScreen.idScreen: (context) => const RegistrationScreen(),
        LoginScreen.idScreen: (context) => const LoginScreen(),
        MainScreen.idScreen: (context) => const MainScreen(),
      },
    );
  }
}
