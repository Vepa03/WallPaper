import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.centerLeft, // Text’i ortalamak için
        children: [
          Image.asset(
            'assets/images/vector2.png', // Örnek resim
            width: 400,
            height: 300,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black54, // Yazının okunabilirliğini artırmak için yarı saydam arka plan
            padding: EdgeInsets.all(8),
            child: Text(
              'Flutter Rocks!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//baba@gmail.com