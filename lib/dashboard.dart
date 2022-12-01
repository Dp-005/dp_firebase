import 'package:dp_firebase/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  User? user;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print(user!.displayName);
      print(user!.email);
      print(user!.uid);
    } else {
      print("not login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
              onPressed: () async {
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return Home();
                  },
                ));
                print("Sign out");
              },
              icon: Icon(Icons.more_vert))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text("${user!.displayName}"),
            Text("${user!.email}"),
            Text("${user!.uid}"),
          ],
        ),
      ),
    );
  }
}
