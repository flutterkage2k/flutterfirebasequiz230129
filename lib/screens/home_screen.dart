import 'package:flutter/material.dart';
import 'package:flutterfirebasequiz230129/auth/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('안내'),
          backgroundColor: Colors.deepPurple,
          leading: Container(),
          actions: [
            TextButton.icon(
              onPressed: () async {
                await AuthService().signOut();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: const Text(
                "",
              ),
            )
          ],
        ),
      ),
    );
  }
}
