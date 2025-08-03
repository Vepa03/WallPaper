
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaper/Pages/HomePage.dart';
import 'package:wallpaper/Pages/RegistrationPage.dart';
import 'package:wallpaper/Pages/WelcomePage.dart';
import 'package:wallpaper/services/auth_service.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginPageState();
}

class _LoginPageState extends State<Loginpage> with TickerProviderStateMixin{

  TextEditingController MailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  String errorMessage = '';

  void register() async {
    try {
      await authService.value.createAccount(
      email: MailController.text, 
      password: PasswordController.text);

      nextPage();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? "There is an error";
      });
      
    }
  
  }

  void nextPage(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Homepage()));
  }
  

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: width,
                      height: height*0.4,
                      child: Lottie.asset("assets/lottie/login.json")),
                    Text("Login" , style: TextStyle(
                      fontSize: width*0.1, 
                      color: Colors.black, 
                      fontWeight: FontWeight.bold, 
                    )),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text("Enter Email"),
                        prefix: Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Icon(Icons.mail, color: Colors.black,),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      controller: MailController,
                    ),
              
                    SizedBox(height: 10.0,),
              
              
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        label: Text("Enter Password"),
                        prefix: Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Icon(Icons.key, color: Colors.black,),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      controller: PasswordController,
                    ),
                    
                    Text(errorMessage, style: TextStyle(color: Colors.red), ),
                    SizedBox(
                      width: width,
                      child: ElevatedButton(onPressed: (){
                        register();
                      }, child: Text("Login", style: TextStyle(fontSize: width*0.06, color: Colors.white, fontWeight: FontWeight.bold),), 
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),),
                    ),
                    SizedBox(height: 10.0,),
                    Text.rich(TextSpan(text: "You don't have an account ?  ", 
                      style: TextStyle(color: Colors.black, fontSize: width*0.04),
                      children: [
                        TextSpan(
                          text: "Click here",
                          style: TextStyle(color: Colors.blue, fontSize: width*0.04),
                          recognizer: TapGestureRecognizer() ..onTap = (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> RegistrationPage()));
                          }
                        ),
                      ])),
                    
          
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}