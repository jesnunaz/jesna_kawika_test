import 'package:flutter/material.dart';
import 'package:machine_test/features/auth/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    username.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: username,
              decoration: InputDecoration(hintText: "Username"),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(hintText: "Password"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AuthProvider>().login(context, username: username.text, password: password.text);
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
