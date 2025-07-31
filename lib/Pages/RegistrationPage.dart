import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        vsync: this, 
        behaviour: RandomParticleBehaviour(
          options: ParticleOptions(
            spawnMaxRadius: 40,
            spawnMinSpeed: 10,
            spawnMaxSpeed: 40,
            particleCount: 80,
            baseColor: Colors.blue
          )
        ),
        child: Column(
          children: [
            
          ],
        ), 
      ),
    );
  }
}