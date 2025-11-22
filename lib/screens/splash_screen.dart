import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void goNext() async {
    await Future.delayed(Duration(seconds: 2));
    // check if user has registered -> if not go to register, else login
    final prefs = await SharedPreferences.getInstance();
    final hasAuth = prefs.getString('uts_auth') != null;
    if (!hasAuth) {
      Navigator.pushReplacementNamed(
          context, '/login'); // login screen has link to register
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void initState() {
    super.initState();
    goNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.indigo, Colors.indigoAccent]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mobile_friendly, size: 96, color: Colors.white),
            SizedBox(height: 16),
            Text('UTS Pemrograman Mobile 2',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            SizedBox(height: 8),
            Text('Nama: Susi Martini\nNPM: 23552011178',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
