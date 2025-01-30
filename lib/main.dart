import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:machine_test/features/auth/models/user_model.dart';
import 'package:machine_test/features/auth/provider/auth_provider.dart';
import 'package:machine_test/features/auth/screens/login.dart';
import 'package:machine_test/features/home/provider/home_provider.dart';
import 'package:machine_test/features/home/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString('token');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => HomeProvider()),
    ],
    child: MyApp(token: token),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.token});
  final String? token;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.token != null) {
        context.read<AuthProvider>().putUserModel(UserModel.fromJson(jsonDecode(widget.token!)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: widget.token == null ? const Login() : const HomeScreen());
  }
}
