import 'dart:developer';

import 'package:carewe/service_home/chat/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ServceController extends GetxController{
  List<dynamic> dutyList=[];
  List<String> emailString=[];
  Map<String,dynamic> dutyChat={};

  void fetchDuty()async{
    dutyList.clear();
    final DocumentReference teacherDocument = FirebaseFirestore.instance
          .collection('s_person')
          .doc('rahul@456');
      final DocumentSnapshot dat = await teacherDocument.get();
      log('${(dat.data() as Map)['duty']}');
      dutyList=(dat.data() as Map)['duty'];
      update();
  }
   void fetchChat()async{
    dutyChat.clear();
    final DocumentReference teacherDocument = FirebaseFirestore.instance
          .collection('s_person')
          .doc('rahul@456');
         
      final DocumentSnapshot dat = await teacherDocument.get();
      log('${(dat.data() as Map)['chat']}',name: 'chat');

      dutyChat=(dat.data() as Map)['chat'];
      for(int i=0;i<dutyChat.length;i++){
emailString.clear();
      
        DocumentReference userdocument = FirebaseFirestore.instance
          .collection('user')
          .doc('${dutyChat.keys.toList()[i]}');
          DocumentSnapshot datUser = await userdocument.get();
          emailString.add((datUser.data() as Map)['fname']);

      }

      update();
  }
}