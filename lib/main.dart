import 'package:flutter/material.dart';
import 'package:stack_q/login_util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? userInfo;
  bool showLoading = false;

  final LoginUtil loginUtil = LoginUtil();

  Future<void> _login() async {
    await Future.delayed(const Duration(seconds: 3));
    loginUtil.login("Jack", 18, callback: (String name, int age) {
      showLoading = false;
      userInfo = "name: $name, age: $age";
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String? text;
    if (userInfo == null) {
      if (!showLoading) {
        text = "You have pushed the button to login";
      } else {
        text = "start login...";
      }
    } else {
      text = "login success: $userInfo";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: Text(text)),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showLoading = true;
          setState(() {});
          await _login();
        },
        tooltip: 'login',
        child: const Icon(Icons.add),
      ),
    );
  }
}
