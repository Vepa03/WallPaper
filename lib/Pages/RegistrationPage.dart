
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper/Pages/HomePage.dart';
import 'package:wallpaper/Pages/LoginPage.dart';
import 'package:wallpaper/services/auth_service.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> with TickerProviderStateMixin{

  TextEditingController MailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  String errorMessage = '';


  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved mail', email);
  }
  
  void register() async {
    try {
      await authService.value.createAccount(
      email: MailController.text, 
      password: PasswordController.text);
      await saveEmail(MailController.text);
      success();
      nextPage();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? "There is an error";
      });
      
    }
  
  }

  void nextPage(){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Homepage()),
      (Route<dynamic> route) => false,
    );
  }

  void success() {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        content: Text("Congratulation you succesfully registered !"),
      ),
    );
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
                      child: Lottie.asset("assets/lottie/signup.json")),
                    Text("Sign Up" , style: TextStyle(
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
                      }, child: Text("Register", style: TextStyle(fontSize: width*0.06, color: Colors.white, fontWeight: FontWeight.bold),), 
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),),
                    ),
                    SizedBox(height: 10.0,),
                    Text.rich(TextSpan(text: "Already registered ?  ", 
                      style: TextStyle(color: Colors.black, fontSize: width*0.04),
                      children: [
                        TextSpan(
                          text: "Click here",
                          style: TextStyle(color: Colors.blue, fontSize: width*0.04),
                          recognizer: TapGestureRecognizer() ..onTap = (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Loginpage()));
                          }
                        ),
                      ])),
                    SizedBox(height: height*0.05,),
                    
          
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