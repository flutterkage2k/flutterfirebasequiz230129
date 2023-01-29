import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebasequiz230129/auth/auth_service.dart';
import 'package:flutterfirebasequiz230129/const.dart';
import 'package:flutterfirebasequiz230129/models/model.dart';
import 'package:flutterfirebasequiz230129/screens/action_button.dart';
import 'package:flutterfirebasequiz230129/screens/quiz_screen.dart';

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
          backgroundColor: Colors.teal,
          elevation: 0,
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
        body: SizedBox.expand(
          child: GradientBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '문제',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('questions').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final questionDocs = snapshot.data!.docs;
                    final questionss = questionDocs.map((e) => Question.fromQueryDocumentSnapshot(e)).toList();

                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('config').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final configDocs = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                        final totalTime = configDocs['key'];

                        return Column(
                          children: [
                            ActionButton(
                              title: "시작",
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => QuizScreen(
                                      totalTime: totalTime,
                                      questions: questionss,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Total Questions: ${questionss.length}',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
