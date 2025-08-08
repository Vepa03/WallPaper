import 'package:flutter/material.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({super.key});

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("About App", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Image.asset('assets/images/Chatbot.png', fit: BoxFit.cover, width: width, height: height*0.4,),
                    ),
                SizedBox(height: 20.0,),
                Text("This application is designed to let you have natural, real-time conversations with an advanced AI powered by OpenAI. Simply type your message and the AI will respond instantly, providing answers, ideas, explanations, or even casual chat. Whether you’re looking for quick information, learning support, creative inspiration, or just a friendly conversation, this app is here to assist you anytime, anywhere. Built with Flutter and seamlessly integrated with the OpenAI API, it delivers a smooth, fast, and engaging user experience. Your words start the conversation — the possibilities are endless.",
                style: TextStyle(color: Colors.black, fontSize: width*0.04),),
                SizedBox(height: 15.0,)
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}