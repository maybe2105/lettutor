import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Message",style: TextStyle(
          color:Colors.black,
          fontSize:16,
        ),),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.search),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(

                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              children: const [
                Icon(Icons.message,size:80 ,color: Colors.blue,),
                Text("No Reccent Chat",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
