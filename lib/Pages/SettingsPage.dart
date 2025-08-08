import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaper/Pages/AboutUs.dart';
import 'package:wallpaper/Pages/DeletAccountPage.dart';
import 'package:wallpaper/Pages/UpdatePassword.dart';
import 'package:wallpaper/Pages/WelcomePage.dart';
import 'package:wallpaper/services/auth_service.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String errorMessage = '';


  void logout() async {
    try {
      await authService.value.signOut();
      nextPage();
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message ?? "There is an error";
    }
    authService.value.signOut();
  }

  void nextPage(){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => WelcomePage()),
      (Route<dynamic> route) => false,
    );
  }

  void logout_allert(){
    showDialog(context: context, builder: (context)=> AlertDialog(
      title: Text('Do you want to Logout ?'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.3,
            height: MediaQuery.of(context).size.height*0.05,
            child: ElevatedButton(onPressed: (){
              logout();
            }, child: Text('Yes', style: TextStyle(fontSize: 20, color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.3,
            height: MediaQuery.of(context).size.height*0.05,
            child: ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('No', style: TextStyle(fontSize: 20, color: Colors.white),), 
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    ));
  }


  void delete_allert(){
    showDialog(context: context, builder: (context)=> AlertDialog(
      title: Text('Do you want to Delete your account ?'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.3,
            height: MediaQuery.of(context).size.height*0.05,
            child: ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Deleteaccountpage()));
            }, child: Text('Yes', style: TextStyle(fontSize: 20, color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.3,
            height: MediaQuery.of(context).size.height*0.05,
            child: ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('No', style: TextStyle(fontSize: 20, color: Colors.white),), 
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    ));
  }



  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                      width: width,
                      height: height*0.3,
                      child: Lottie.asset("assets/lottie/settings.json")),
                
                    ListTile(
                      title: Text("Change Password", style: TextStyle(color: Colors.black, fontSize: width*0.045),),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdatePassword()));
                      },
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black,),
                    ),
          
                    ListTile(
                      title: Text("Delete Account", style: TextStyle(color: Colors.black, fontSize: width*0.045),),
                      onTap: (){
                        delete_allert();
                      },
                      trailing: Icon(Icons.delete_outlined, color: Colors.black,),
                    ),
                    ListTile(
                      title: Text("About this app", style: TextStyle(color: Colors.black, fontSize: width*0.045),),
                      trailing: Icon(Icons.info_outline, color: Colors.black,),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Aboutus()));
                      }
                    ),
                    ListTile(
                      title: Text("Logout", style: TextStyle(color: Colors.red, fontSize: width*0.045, fontWeight: FontWeight.bold),),
                      trailing: Icon(Icons.logout, color: Colors.red,),
                      onTap: (){
                        logout_allert();
                      }
                    ),
                    
                    SizedBox(height: 30.0),
                    Text(errorMessage, style: TextStyle(color: Colors.red)),
          
            ],
          ),
        ),
      ),
    );
  }
}