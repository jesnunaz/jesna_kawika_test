import 'package:flutter/material.dart';
import 'package:machine_test/features/auth/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var userdata = context.watch<AuthProvider>().userModel;
    return ListView(
      padding: EdgeInsets.all(30),
      children: [
        CircleAvatar(
          radius: 80,
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(userdata!.image!),
        ),
        const SizedBox(height: 30),
        Center(child: Text("${userdata.firstName} ${userdata.lastName}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18))),
        const SizedBox(height: 10),
        Center(child: Text("Email: ${userdata.email!}", style: TextStyle(fontSize: 14))),
        const SizedBox(height: 10),
        Center(child: Text("Username: ${userdata.username!}", style: TextStyle(fontSize: 14))),
        const SizedBox(height: 10),
        Center(child: Text("Gender: ${userdata.gender!}", style: TextStyle(fontSize: 14))),
        const SizedBox(height: 30),
        ElevatedButton(
            onPressed: () {
              context.read<AuthProvider>().logout(context);
            },
            child: Text("Log out"))
      ],
    );
  }
}
