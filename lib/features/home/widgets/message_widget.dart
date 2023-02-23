import 'package:amlelshefaa/core/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({required this.messgaeModel});

  final MessageModel messgaeModel;

  @override
  Widget build(BuildContext context) {
    return (messgaeModel.isMyMessage)
        ? Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${messgaeModel.sender}'),
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        '${messgaeModel.text}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${messgaeModel.sender}'),
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30), topRight: Radius.circular(30)),
                    color: Color(0xffAAACAE),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        '${messgaeModel.text}',
                        style: TextStyle(
                          color: Color(0xff1A1D21),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
