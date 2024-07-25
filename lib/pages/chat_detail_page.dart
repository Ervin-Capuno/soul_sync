import 'package:flutter/material.dart';
import 'dart:io';
import 'package:tinder_clone/data/image_picker.dart';

class ChatDetailPage extends StatefulWidget {
  final String name;
  final String img;

  ChatDetailPage({required this.name, required this.img});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<Map<String, dynamic>> messages = [];
  TextEditingController _controller = TextEditingController();
  final ImagePickerService _imagePickerService = ImagePickerService();

  void sendMessage(String message) {
    setState(() {
      messages.add({
        "sender": "You",
        "message": message,
        "type": "text",
        "time": DateTime.now().toString()
      });
      _controller.clear();
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          messages.add({
            "sender": widget.name,
            "message": "Hi, Kate! How are you?",
            "type": "text",
            "time": DateTime.now().toString()
          });
        });
      });
    });
  }

  Future<void> sendImage() async {
    final pickedFile = await _imagePickerService.pickImageFromGallery();
    if (pickedFile != null) {
      setState(() {
        messages.add({
          "sender": "You",
          "message": pickedFile.path,
          "type": "image",
          "time": DateTime.now().toString()
        });
        
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            messages.add({
              "sender": widget.name,
              "message": "Nice image!",
              "type": "text",
              "time": DateTime.now().toString()
            });
          });
        });
      });
    } else {
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple, 
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.img),
            ),
            SizedBox(width: 10),
            Text(
              widget.name,
              style: TextStyle(color: Colors.white), 
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[messages.length - 1 - index];
                final isMe = message['sender'] == "You";
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        if (message['type'] == 'text')
                          Container(
                            decoration: BoxDecoration(
                              color: isMe ? Colors.purple : Colors.grey[600], 
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            child: Text(
                              message['message'],
                              style: TextStyle(color: Colors.white), 
                            ),
                          )
                        else if (message['type'] == 'image')
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Builder(
                              builder: (context) {
                                try {
                                  return File(message['message']).existsSync()
                                      ? Image.file(
                                          File(message['message']),
                                          width: 200,
                                        )
                                      : Text('File not found', style: TextStyle(color: Colors.red));
                                } catch (e) {
                                  return Text('Error loading image', style: TextStyle(color: Colors.red));
                                }
                              },
                            ),
                          ),
                        SizedBox(height: 5),
                        Text(
                          message['time'].split(' ')[1].substring(0, 5),
                          style: TextStyle(fontSize: 10, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: sendImage,
                  color: Colors.purple, 
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Enter a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(_controller.text);
                    }
                  },
                  color: Colors.purple, 
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
