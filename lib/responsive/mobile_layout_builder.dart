import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:provider/provider.dart';

class MobileBuilder extends StatelessWidget {
  const MobileBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: AuthMethods().signOut,
            icon: const Icon(Icons.logout_rounded))
      ]),
      body: Center(child: Text(user.email)),
    );
  }
}
