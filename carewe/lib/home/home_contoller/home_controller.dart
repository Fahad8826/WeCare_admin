import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  bool islodin = false;
  List<dynamic> appList = [];
  List<dynamic> catergorypeople = [];
  int checkindex = 0;
  Map<String, dynamic> persondetails = {};
  final List<String> servicesdb = [
    'Transportation',
    'Shopping',
    'Personal Assistant',
    'Hospital Companion',
    'Hygiene and Toileting',
    'Dressing Grooming',
    'Companionship',
    'Med Administration',
    'Meal preparing',
    'Laundry',
    'cleaning',
  ];
  int index = 0;
  void indexchange(int iindex) {
    index = iindex;
    update();
  }

  Future<void> personDetailsFetch() async {
    islodin = true;
    update();
    for (int i = 0; i < servicesdb.length; i++) {
      final DocumentReference teacherDocument = FirebaseFirestore.instance
          .collection('ad_ser')
          .doc('${servicesdb[i]}');
      final DocumentSnapshot dat = await teacherDocument.get();
      log('${(dat.data() as Map)['person']}');
      // List fbval = ((dat.data() as Map)['person']) as List;
      persondetails[servicesdb[i]] = ((dat.data() as Map)['person']) as List;
      log('${persondetails}');
    }
    // update();
  //  / categorIndex(0);
  }

  void categorIndex(int indexv)async {
    log('njan');
     checkindex = indexv;
     update();
    // islodin = true;
    // update();
    await personDetailsFetch();
    catergorypeople.clear();
   
    Map<String, dynamic> localperso=persondetails;
    if (indexv == 0) {
      for (int i = 0; i < localperso.values.toList().length; i++) {
        for (int j = 0;
            j < (localperso.values.toList()[i] as List).length;
            j++) {
          catergorypeople.add(localperso.values.toList()[i][j]);
        }
      }
    } else {
      catergorypeople = localperso[servicesdb[indexv - 1]];
    }
    log(persondetails.toString(),name: 'list');
         islodin = false;
    update();
  }

  void dutyFetch() async {
    

    appList.clear();
    log('called');
    final DocumentReference teacherDocument =
        FirebaseFirestore.instance.collection('ad_duty').doc('duty');
    final DocumentSnapshot dat = await teacherDocument.get();
    log('${dat.data()}');
    final List fbval = (dat.data() as Map)['appon'] as List;
     appList = fbval;
    log('called2 $fbval');
    update();
  }
}
