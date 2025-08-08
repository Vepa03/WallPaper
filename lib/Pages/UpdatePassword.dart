import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaper/Pages/HomePage.dart';
import 'package:wallpaper/services/auth_service.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  
  TextEditingController MailController = TextEditingController();
  TextEditingController CurrentController = TextEditingController();
  TextEditingController NewController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  void update() async {
    try {
      await authService.value.resetPasswordfromCurrentPasswoord(
        email: MailController.text, 
        currentPassword: CurrentController.text, 
        newPassword: NewController.text);
        success();
        next();
    } catch (e) {
      failer();
    }
  }

  void next(){
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
        content: Text("Your password is changed"),
      ),
    );
  }
  void failer() {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        content: Text("Something went wrong"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, iconTheme: IconThemeData(color: Colors.white),
      centerTitle: true,
      title: Text("Change Password", style: TextStyle(fontSize: width*0.07, color: Colors.white, fontWeight: FontWeight.bold),),),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(height: 10.0,),
                  SizedBox(
                    width: width,
                    height: height*0.3,
                    child: Lottie.asset("assets/lottie/updatepassword.json")),
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
                            label: Text("Enter your current password"),
                            prefix: Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Icon(Icons.key, color: Colors.black,),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: CurrentController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Current passwrod is required";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0,),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text("Enter your new password"),
                            prefix: Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Icon(Icons.key, color: Colors.black,),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: NewController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "New password is required";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0,),
                        SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.05,
                        child: ElevatedButton(onPressed: (){
                          if (_formkey.currentState!.validate()) {
                            update();
                          }
                        }, child: Text('Change', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),), 
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),),
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