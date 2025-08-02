import 'package:animated_background/animated_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/Pages/HomePage.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/images/vector2.png", width: width,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text("Welcome" , style: TextStyle(fontSize: width*0.09, color: Colors.black, fontWeight: FontWeight.bold),),
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
                SizedBox(height: 10.0,),
                SizedBox(
                  width: width,
                  child: ElevatedButton(onPressed: (){
                    register();
                  }, child: Text("Register", style: TextStyle(fontSize: width*0.06, color: Colors.white, fontWeight: FontWeight.bold),), 
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),),
                ),
                
              ],
            ),
          ),
          Image.asset("assets/images/vector1.png", width: width,)
        ],
      ),
    );
  }
}