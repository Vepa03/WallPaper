import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaper/Pages/LoginPage.dart';
import 'package:wallpaper/Pages/RegistrationPage.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Wallpaper App", style: TextStyle(
                  fontSize: width*0.1, 
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
            Lottie.asset("assets/lottie/welcome.json", width: width),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: width*0.45,
                  height: height*0.05,
                  child: OutlinedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> RegistrationPage()));
                  }, child: Text("Sing Up", style: TextStyle(fontSize: width*0.05, color: Colors.black),),),
                ),
                SizedBox(
                  width: width*0.45,
                  height: height*0.05,
                  child: FilledButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Loginpage()));
                  }, child: Text("Login", style: TextStyle(color: Colors.white, fontSize: width*0.05),), 
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.deepPurple
                  ),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}