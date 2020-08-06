import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/MessagingService.dart';
import 'package:syana/widgets/CustomButton.dart';
import 'package:syana/widgets/CustomTextInput.dart';

class BroadcastMessage extends StatefulWidget {
  _BroadcastState createState() => _BroadcastState();
}

class _BroadcastState extends State<BroadcastMessage> {
  TextEditingController _messageController = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  sendMessage() {
     MessagingService.sendMessage(_messageController.text, context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen[200],
          title: Text('Broadcast'),
        ),
        body: Container(
          decoration: AppTheme.appBackground(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: CustomTextInput.getCustomTextField(
                    context: context,
                    controller: _messageController,
                    textInputType: TextInputType.text,
                    hint: "Masukkan pesan"),
              ),
              Container(
                child: CustomButton.getCustomButton(
                    context: context,
                    callbackFunction: sendMessage,
                    buttonText: "Kirim"),
              )
            ],
          ),
        ));
  }
}
