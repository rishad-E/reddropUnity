import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reddropunity/Screen/adduser.dart';
import 'package:reddropunity/Screen/home.dart';
import 'package:reddropunity/Screen/updateuser.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomeScreen(),
        '/add': (context) => const AddUserScreen(),
        '/update':(context) => const UpdateUserScreen()
      },
      initialRoute: '/',
    );
  }
}
