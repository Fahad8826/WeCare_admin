import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

class ChatController extends GetxController {
  List<dynamic> messages = [];
  Future<void> sendMessage(String personId, String message,String email) async {
    final DocumentReference document =
        FirebaseFirestore.instance.collection('s_person').doc(personId);
    log('${document.get()}');
    final DocumentSnapshot dt = await document.get();
    final val = dt.data();
    log('${(dt.data() as Map)['chat']}');
    // log('${((val as Map)['chat'][FirebaseAuth.instance.currentUser!.email])}',name: 'hi');
    if ('${(dt.data() as Map)['chat']}' == 'null') {
      log('hai');
      final Map<String, dynamic> msg = {
        'isUser': true,
        'message': message,
        'time': DateTime.now().toString(),
      };

      final Map<String, dynamic> sm = {
        '${email}': [msg]
      };
      await document.update({'chat': sm});
    } else {
      if ('${((val as Map)['chat'][email])}' !=
          'null') {
        List lList = [];
        lList = ((val as Map)['chat']
                [email]) ??
            [];

        final Map<String, dynamic> msg = {
          'isUser': false,
          'message': message,
          'time': DateTime.now().toString(),
        };
        log('${lList}');
        lList.add(msg);
        final Map<String, dynamic> sm = {
          '${email}': lList
        };
        await document.update({'chat': sm});
      } else {
        final Map<String, dynamic> msg = {
          'isUser': false,
          'message': message,
          'time': DateTime.now().toString(),
        };

        final Map<String, dynamic> sm = {
          '${email}': [msg]
        };
        await document.update({'chat': sm});
      }
    }
    fetchMessages(personId,email);
  }

  Future<void> fetchMessages(String personId,String email) async {
    final DocumentReference document =
        FirebaseFirestore.instance.collection('s_person').doc(personId);
    DocumentSnapshot snapshot = await document.get();
    final val = snapshot.data();
    if (snapshot.exists) {
      messages = ((val as Map)['chat']
              [email]) ??
          [];
      log('${messages}');
    } else {}
    update();
  }
}
