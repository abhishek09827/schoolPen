import 'package:aie_project/screens/sign_up_step2.dart';
import 'package:aie_project/screens/verify_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'screens/login_page.dart';
void main() {
  runApp(const MyHomePage());
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthScreen(),
      builder: EasyLoading.init(),
      // AuthScreen(),
    );
  }
}
