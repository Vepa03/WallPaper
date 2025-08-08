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
        backgroundColor: Colors.indigo,
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
                Text("Library is a simple and user-friendly application designed to help you discover, read, and organize books easily. Whether you're a passionate reader or just starting your reading journey, Library offers a clean and efficient way to explore various authors and their works.\n\n🌟 Features:\n\nRead book details and access content directly\n\nMinimal and clean design for distraction-free reading\n\n💡 Why Library?\n\nWe believe everyone should have easy access to literature. Library was built with love to promote reading and make books more accessible — anytime, anywhere.",
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