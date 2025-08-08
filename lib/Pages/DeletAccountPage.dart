import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper/Pages/WelcomePage.dart';
import 'package:wallpaper/services/auth_service.dart';

class Deleteaccountpage extends StatefulWidget {
  const Deleteaccountpage({super.key});

  @override
  State<Deleteaccountpage> createState() => _DeleteaccountpageState();
}

class _DeleteaccountpageState extends State<Deleteaccountpage> {
  
  TextEditingController MailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  String errorMessage = '';

  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved mail', email);
  }

  void deleteAccount() async{
    try {
      await authService.value.deleteAccount(
        email: MailController.text, 
        password: PasswordController.text);
        await saveEmail(MailController.text);
      next();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? "Something went wrong";
      });
    }
  }

  void next(){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => WelcomePage()),
      (Route<dynamic> route) => false,
    );
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, iconTheme: IconThemeData(color: Colors.white),
      centerTitle: true,
      title: Text("Delete Account", style: TextStyle(fontSize: width*0.07, color: Colors.white, fontWeight: FontWeight.bold),),),
      body:SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formkey,
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width,
                        height: height*0.3,
                        child: Lottie.asset("assets/lottie/delete.json")),
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Enter your mail"),
                          prefix: Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Icon(Icons.mail, color: Colors.black,),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        controller: MailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Mail is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0,),
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("Enter your password"),
                          prefix: Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Icon(Icons.key, color: Colors.black),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: PasswordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0,),
                      Text(errorMessage, style: TextStyle(color: Colors.red),),
                      SizedBox(height: 10.0,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.05,
                        child: ElevatedButton(onPressed: (){
                          if (_formkey.currentState!.validate()) {
                            deleteAccount();
                          }
                        }, child: Text('Delete', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),), 
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),),
                      ),
                    ],
                  ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}