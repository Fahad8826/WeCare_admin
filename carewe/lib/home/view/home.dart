import 'dart:developer';

import 'package:carewe/home/home_contoller/home_controller.dart';
import 'package:carewe/person_add/view/person_add.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart' as cl;
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final HomeC;

  @override
  void initState() {
    HomeC = Get.put(HomeController());
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      log('hil${_tabController.index}');
      if (_tabController.index == 0) {
        HomeC.indexchange(_tabController.index);

        HomeC.dutyFetch();
      } else {
        // HomeC.personDetailsFetch();
        HomeC.categorIndex(0);
      }
      print('Current Tab Index: ${_tabController.index}');
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GetBuilder<HomeController>(
        initState: (state) {
          HomeC.dutyFetch();
        },
        builder: (controller) {
          log('${HomeC.index}');
          return _tabController.index == 1
              ? FloatingActionButton(
                  onPressed: () {
                    Get.to(UserDetailsForm());
                  },
                  child: Text('+'),
                )
              : SizedBox();
        },
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 15, 105, 135), // Light Blue
                Color.fromARGB(255, 47, 99, 168),
                Color.fromARGB(255, 38, 72, 98), // Pinkish Red
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
        ),
        leading: Text(''),
        title: Text(
          'Admin Dashboard',
          style: TextStyle(color: const Color.fromARGB(255, 227, 227, 227)),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color.fromARGB(255, 227, 227, 227),
          unselectedLabelColor: const Color.fromARGB(255, 227, 227, 227),
          onTap: (value) {
            log('$value');
            // HomeC.indexchange(value);
            // HomeC.personDetailsFetch();
            // HomeC.dutyFetch();
            // HomeC.categorIndex(0);
          },
          tabs: [
            Tab(
              text: 'Duties',
            ),
            Tab(text: 'Persons'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          DutyDetailsTab(),
          NewpersonPage()
          // PersonDetailsTab(
          //   homc: HomeC,
          // ),
        ],
      ),
    );
  }
}

class DutyDetailsTab extends StatelessWidget {
  final List<Map<String, String>> duties = [
    {
      'serviceName': 'Personal Care',
      'name': 'John Doe',
      'selectedPerson': 'Jane Smith',
      'date': '2025-02-15',
      'time': '10:00 AM',
    },
    {
      'serviceName': 'Home Care',
      'name': 'Alice Johnson',
      'selectedPerson': 'Bob Brown',
      'date': '2025-02-16',
      'time': '11:00 AM',
    },
    // Add more duties as needed
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return ListView.builder(
          itemCount: controller.appList.length,
          itemBuilder: (context, index) {
            // final duty = duties[index];
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(17),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF6A82FB), // Light Blue
                          Color(0xFFFC5C7D)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        controller.appList[index]['service']!,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 247, 247, 247)),
                      ),
                      subtitle: Text(
                          'Name: ${controller.appList[index]['name']}\nSelected Person: ${controller.appList[index]['person']['name']}\nDate: ${controller.appList[index]['date']}\nTime: ${controller.appList[index]['time']}',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 219, 219, 219))),
                    ),
                  ),
                ),
                Positioned(
                  top: 18,
                  right: 10,
                  child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(controller.appList[index]
                                          ['service'] ==
                                      'Companionship'
                                  ? 'https://cdn.dribbble.com/userupload/23049293/file/original-e4a717f34789285589643bdda641506f.gif'
                                  : controller.appList[index]['service'] ==
                                          'Shopping'
                                      ? 'https://cdn.dribbble.com/userupload/21903715/file/original-2297feaec1ba5f6406c8694d0880aae9.gif'
                                      : controller.appList[index]['service'] ==
                                              'Transportation'
                                          ? 'https://cdn.dribbble.com/userupload/23154695/file/original-95c4f350244238203245af789ee5ba7e.gif'
                                          : controller.appList[index]['service'] ==
                                                  'Hospital Companion'
                                              ? 'https://i.pinimg.com/originals/db/f3/c9/dbf3c92ca8525611209c7a5ac42405a3.gif'
                                              : controller.appList[index]
                                                          ['service'] ==
                                                      'Meal preparing'
                                                  ? 'https://cdn.dribbble.com/userupload/24942251/file/original-9c5cccaf493bcd4eec55b1835dfedc3d.gif'
                                                  : controller.appList[index]
                                                              ['service'] ==
                                                          'Hygiene and Toileting'
                                                      ? 'https://i.gifer.com/O6cw.gif'
                                                      : controller.appList[index]
                                                                  ['service'] ==
                                                              'Dressing Grooming'
                                                          ? 'https://media.tenor.com/OgAGmSx8De8AAAAM/george-jetson-getting-dressed.gif'
                                                          : controller.appList[index]
                                                                      ['service'] ==
                                                                  'Laundry'
                                                              ? 'https://mir-s3-cdn-cf.behance.net/project_modules/hd/ed5a3179024277.5cbca8251c762.gif'
                                                              : 'https://i.pinimg.com/originals/50/a8/57/50a857a7bbe36010c73c07792f1004f4.gif')),
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ])),
                )
              ],
            );
          },
        );
      },
    );
  }
}

// class PersonDetailsTab extends StatelessWidget {
//   final HomeController homc;

//   const PersonDetailsTab({super.key, required this.homc});
//   // final List<Map<String, dynamic>> people = [
//   //   {
//   //     'name': 'John Doe',
//   //     'age': 30,
//   //     'gender': 'Male',
//   //     'image':
//   //         'https://via.placeholder.com/150', // Replace with actual image URLs
//   //   },
//   //   {
//   //     'name': 'Jane Smith',
//   //     'age': 25,
//   //     'gender': 'Female',
//   //     'image':
//   //         'https://via.placeholder.com/150', // Replace with actual image URLs
//   //   },
//   //   // Add more people as needed
//   // ];

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeController>(
//       builder: (controller) {
//         return homc.islodin
//             ? Center(
//                 child: CircularProgressIndicator(),
//               )
//             : Column(children: [
//                 SizedBox(
//                   height: 10,
//                 ),
//                 SizedBox(
//                     height: 50,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: homc.servicesdb.length,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () {
//                             homc.categorIndex(index);
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(13),
//                                   color: homc.checkindex == index
//                                       ? const Color.fromARGB(255, 108, 95, 171)
//                                       : const Color.fromARGB(
//                                           255, 170, 155, 235)),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(12.0),
//                                 child: Text(
//                                   index == 0
//                                       ? 'All'
//                                       : homc.servicesdb[index - 1],
//                                   style: TextStyle(
//                                       fontSize: 15, color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     )),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: homc.catergorypeople.length,
//                     itemBuilder: (context, index) {
//                       log('hh${homc.catergorypeople}');
//                       final person = homc.catergorypeople[index];
//                       log('${person['pic'].toString()}', name: 'img');
//                       return ListTile(
//                         leading: !person['pic'].toString().contains('http')
//                             ? SizedBox(
//                                 child: CircleAvatar(
//                                   child: Icon(Icons.person),
//                                 ),
//                               )
//                             : Image.network(person['pic'].toString()!),
//                         title: Text(person['name']!),
//                         subtitle: Text(
//                             'Age: ${person['age']}\nGender: ${person['gender']}'),
//                       );
//                     },
//                   ),
//                 ),
//               ]);
//       },
//     );
//   }
// }

class NewpersonPage extends StatelessWidget {
  NewpersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    final HomeController homc = Get.put(HomeController());
    return Scaffold(
      body: SizedBox(
        // height: MediaQuery.sizeOf(context).height+50,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(13),
                  color: const Color.fromARGB(255, 16, 142, 170),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ClipPath(
                      clipper: cl.MovieTicketClipper(),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 60, 151, 95),
                              const Color.fromARGB(255, 74, 195, 120),
                              const Color.fromARGB(255, 60, 151, 95)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        // color: const Color.fromARGB(255, 19, 196, 81),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "May your actions today light up someone's path and make their journey a little brighter. Have a wonderful day dedicated to spreading kindness and positivity!.....",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Material(
            //     elevation: 10,
            //     borderRadius: BorderRadius.circular(14),
            //     child: TextField(
            //       controller: _controller,
            //       decoration: InputDecoration(
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(14),
            //         ),
            //         labelText: 'Search',
            //       ),
            //     ),
            //   ),
            // ),
            GetBuilder<HomeController>(
              builder: (controller) {
                return Container(
                  height: 270,
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: controller.servicesdb.length,
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 1.0,
                          childAspectRatio: 0.6 / 1.1),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => controller.categorIndex(index),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              elevation: 10,
                              borderRadius: BorderRadius.circular(13),
                              color: controller.checkindex == index
                                  ? const Color.fromARGB(255, 179, 213, 239)
                                  : const Color.fromARGB(255, 245, 249, 250),
                              child: ClipPath(
                                clipper: cl.WaveClipperOne(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: Colors.blue,
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.blue[
                                            300]!, // Lighter shade of blue
                                        Colors.blue[
                                            700]!, // Darker shade of blue
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  margin: EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text(
                                    '${index == 0 ? 'All' : controller.servicesdb[index - 1]}',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Personn Details',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
            Expanded(child: GetBuilder<HomeController>(
              builder: (controller) {
                return
                    // controller.islodin
                    //     ? Center(
                    //         child: CircularProgressIndicator(),
                    //       )
                    //     :
                    ListView.builder(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.catergorypeople.length,
                  itemBuilder: (context, index) {
                    log('hh${controller.catergorypeople}');
                    final person = controller.catergorypeople[index];
                    log('${person['pic'].toString()}', name: 'img');
                    return Skeletonizer(
                      enabled: controller.islodin,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          color: const Color.fromARGB(255, 63, 181, 190),
                          elevation: 10,
                          borderRadius: BorderRadius.circular(13),
                          child: ClipPath(
                            clipper: cl.SideCutClipper(),
                            child: Container(
                              height: MediaQuery.sizeOf(context).height * 0.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: Colors.blue,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors
                                        .blue[300]!, // Lighter shade of blue
                                    Colors.blue[700]!, // Darker shade of blue
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: ListTile(
                                leading:
                                    !person['pic'].toString().contains('http')
                                        ? SizedBox(
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Icon(Icons.person),
                                            ),
                                          )
                                        : Image.network(
                                            person['pic'].toString()!),
                                title: Text(
                                  person['name']!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  'Age: ${person['age']}\nGender: ${person['gender']}',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 229, 229, 229),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
