import 'package:flutter/material.dart';
import 'package:wallpaper/Pages/SettingsPage.dart';
import 'package:wallpaper/services/api_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final _controller = TextEditingController();
  final List<String> _messages = [];
  bool _isLoading = false;

  void _sendMessage() async {
    final message = _controller.text.trim();
    if (message.isEmpty) return;

    setState(() {
      _messages.add("👤 $message");
      _isLoading = true;
      _controller.clear();
    });

    final result = await ApiService.getAIResponse(message);

    setState(() {
      _messages.add("🤖 $result");
      _isLoading = false;
    });
  }

  void reset(){
    showDialog(context: context, builder: (context)=> AlertDialog(
      title: Text("Do you want to reset?"),
      content: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.3,
            child: OutlinedButton(onPressed: (){
              setState(() {
                _messages.clear();
              });
            }, child: Text("Yes", style: TextStyle(color: Colors.black, fontSize: 20),)))
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Chatbot", style: TextStyle(color: Colors.white),),
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: [
        Row(
          children: [
            IconButton(onPressed: (){
              setState(() {
                _messages.clear();
              });;
            }, icon: Icon(Icons.restart_alt, color: Colors.white,)),
            IconButton(onPressed: (){
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Settings()));
              });
            }, icon: Icon(Icons.settings, color: Colors.white,)),
          ],
        )
      ],
      backgroundColor: Colors.black,),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(_messages[index], style: TextStyle(fontSize: 15),),
                );
              },
            ),
          ),
          if (_isLoading) Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: CircularProgressIndicator(),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Ask anything",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.send_rounded, color: Colors.black,),
                    onPressed: _isLoading ? null : _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
