// import 'dart:developer' as dev;

// // import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:syana/utils/GlobalFunctions.dart';
// import 'package:syana/utils/GlobalVars.dart';
// import 'package:syana/utils/Strings.dart';
// import 'package:syana/widgets/CustomDialog.dart';

// class MessagingService {
//   static Future getNotification(FirebaseMessaging fcm, BuildContext context) {
//     int is_message_received = 0;
//     fcm.configure(onMessage: (Map<String, dynamic> message) async {
//       CustomDialog.getDialog(
//           title: Strings.DIALOG_TITLE_NOTIFICATION,
//           message: "Test",
//           context: context,
//           popCount: 1);
//       dev.log("onMessage : $message", name: "messaging_service");

//       /*if (!GlobalVars.fcm_message_received) {

//         GlobalVars.fcm_message_received = true;
//       } else {
//         GlobalVars.fcm_message_received = false;
//       }
//       is_message_received++;*/
//       // CustomDialog.getDialog(, message, context)
//     }, onResume: (Map<String, dynamic> message) async {
//       print("onResume : $message");
//     }, onLaunch: (Map<String, dynamic> message) async {
//       print("onLaunch : $message");
//     });
//   }

//   static sendMessage(
//     message,
//     context,
//   ) async {
//     var params = GlobalFunctions.generateMapParam(["message"], [message]);

//     final data = await GlobalFunctions.dioGetCall(
//         context: context,
//         params: params,
//         path: GlobalVars.apiUrl + "send-broadcast");

//     if (data != null) {
//       if (data['status'] == 1) {
//         Navigator.of(context).pop();
//         Navigator.of(context).pop();
//         CustomDialog.getDialog(
//             title: Strings.DIALOG_TITLE_SUCCESS,
//             message: Strings.DIALOG_MESSAGE_BROADCAST_MESSAGE_SENT,
//             context: context,
//             popCount: 1);
//       }
//     }
//   }
// }
