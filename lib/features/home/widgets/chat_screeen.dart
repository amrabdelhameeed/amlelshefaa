import 'package:amlelshefaa/core/models/message_model.dart';
import 'package:amlelshefaa/core/utils/app_colors.dart';
import 'package:amlelshefaa/features/home/widgets/message_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({required this.name});
  final String name;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

TextEditingController textEditingController = TextEditingController();

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General Chat'),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('chat').orderBy('time').snapshots(),
            builder: (context, snapshot) {
              List<MessageWidget> messageWidgets = [];
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              final messages = snapshot.data!.docs.reversed;
              for (var message in messages) {
                final messageText = message.get('text');
                if (messageText == null || message.get('name') == null) {
                } else {
                  messageWidgets.add(MessageWidget(
                      messgaeModel: MessageModel(
                    dateTime: DateTime.now().toString(),
                    text: messageText,
                    sender: message.get('name'),
                    isMyMessage: widget.name == message.get('name'),
                  )));
                }
              }
              return Expanded(
                child: ListView(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  children: messageWidgets,
                ),
              );
            },
          ),
          Container(
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black, width: 2))),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Type Text",
                  ),
                  controller: textEditingController,
                )),
                IconButton(
                    onPressed: () {
                      if (textEditingController.text.isNotEmpty) {
                        FirebaseFirestore.instance.collection('chat').add({
                          'name': widget.name,
                          'text': textEditingController.text,
                          'time': DateTime.now(),
                        }).then((value) {
                          textEditingController.clear();
                        });
                      }
                    },
                    icon: const Icon(Icons.abc)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
