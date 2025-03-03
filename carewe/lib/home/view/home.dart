// import 'dart:developer';

// import 'package:carewe/home/home_contoller/home_controller.dart';
// import 'package:carewe/person_add/view/person_add.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart' as cl;
// import 'package:skeletonizer/skeletonizer.dart';

// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   late final HomeC;

//   @override
//   void initState() {
//     HomeC = Get.put(HomeController());
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _tabController.addListener(() {
//       log('hil${_tabController.index}');
//       if (_tabController.index == 0) {
//         HomeC.indexchange(_tabController.index);

//         HomeC.dutyFetch();
//       } else {
//         // HomeC.personDetailsFetch();
//         HomeC.categorIndex(0);
//       }
//       print('Current Tab Index: ${_tabController.index}');
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: GetBuilder<HomeController>(
//         initState: (state) {
//           HomeC.dutyFetch();
//         },
//         builder: (controller) {
//           log('${HomeC.index}');
//           return _tabController.index == 1
//               ? FloatingActionButton(
//                   onPressed: () {
//                     Get.to(UserDetailsForm());
//                   },
//                   child: Text('+'),
//                 )
//               : SizedBox();
//         },
//       ),
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color.fromARGB(255, 15, 105, 135), // Light Blue
//                 Color.fromARGB(255, 47, 99, 168),
//                 Color.fromARGB(255, 38, 72, 98), // Pinkish Red
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.topRight,
//             ),
//           ),
//         ),
//         leading: Text(''),
//         title: Text(
//           'Admin Dashboard',
//           style: TextStyle(color: const Color.fromARGB(255, 227, 227, 227)),
//         ),
//         bottom: TabBar(
//           controller: _tabController,
//           labelColor: const Color.fromARGB(255, 227, 227, 227),
//           unselectedLabelColor: const Color.fromARGB(255, 227, 227, 227),
//           onTap: (value) {
//             log('$value');
//             // HomeC.indexchange(value);
//             // HomeC.personDetailsFetch();
//             // HomeC.dutyFetch();
//             // HomeC.categorIndex(0);
//           },
//           tabs: [
//             Tab(
//               text: 'Duties',
//             ),
//             Tab(text: 'Persons'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           DutyDetailsTab(),
//           NewpersonPage()
//           // PersonDetailsTab(
//           //   homc: HomeC,
//           // ),
//         ],
//       ),
//     );
//   }
// }

// class DutyDetailsTab extends StatelessWidget {
//   final List<Map<String, String>> duties = [
//     {
//       'serviceName': 'Personal Care',
//       'name': 'John Doe',
//       'selectedPerson': 'Jane Smith',
//       'date': '2025-02-15',
//       'time': '10:00 AM',
//     },
//     {
//       'serviceName': 'Home Care',
//       'name': 'Alice Johnson',
//       'selectedPerson': 'Bob Brown',
//       'date': '2025-02-16',
//       'time': '11:00 AM',
//     },
//     // Add more duties as needed
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeController>(
//       builder: (controller) {
//         return ListView.builder(
//           itemCount: controller.appList.length,
//           itemBuilder: (context, index) {
//             // final duty = duties[index];
//             return Stack(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.amber,
//                       borderRadius: BorderRadius.circular(17),
//                       gradient: LinearGradient(
//                         colors: [
//                           Color(0xFF6A82FB), // Light Blue
//                           Color(0xFFFC5C7D)
//                         ],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           spreadRadius: 2,
//                           blurRadius: 7,
//                           offset: Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: ListTile(
//                       title: Text(
//                         controller.appList[index]['service']!,
//                         style: TextStyle(
//                             color: const Color.fromARGB(255, 247, 247, 247)),
//                       ),
//                       subtitle: Text(
//                           'Name: ${controller.appList[index]['name']}\nSelected Person: ${controller.appList[index]['person']['name']}\nDate: ${controller.appList[index]['date']}\nTime: ${controller.appList[index]['time']}',
//                           style: TextStyle(
//                               color: const Color.fromARGB(255, 219, 219, 219))),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 18,
//                   right: 10,
//                   child: Container(
//                       height: 100,
//                       width: 100,
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                               fit: BoxFit.cover,
//                               image: NetworkImage(controller.appList[index]
//                                           ['service'] ==
//                                       'Companionship'
//                                   ? 'https://cdn.dribbble.com/userupload/23049293/file/original-e4a717f34789285589643bdda641506f.gif'
//                                   : controller.appList[index]['service'] ==
//                                           'Shopping'
//                                       ? 'https://cdn.dribbble.com/userupload/21903715/file/original-2297feaec1ba5f6406c8694d0880aae9.gif'
//                                       : controller.appList[index]['service'] ==
//                                               'Transportation'
//                                           ? 'https://cdn.dribbble.com/userupload/23154695/file/original-95c4f350244238203245af789ee5ba7e.gif'
//                                           : controller.appList[index]['service'] ==
//                                                   'Hospital Companion'
//                                               ? 'https://i.pinimg.com/originals/db/f3/c9/dbf3c92ca8525611209c7a5ac42405a3.gif'
//                                               : controller.appList[index]
//                                                           ['service'] ==
//                                                       'Meal preparing'
//                                                   ? 'https://cdn.dribbble.com/userupload/24942251/file/original-9c5cccaf493bcd4eec55b1835dfedc3d.gif'
//                                                   : controller.appList[index]
//                                                               ['service'] ==
//                                                           'Hygiene and Toileting'
//                                                       ? 'https://i.gifer.com/O6cw.gif'
//                                                       : controller.appList[index]
//                                                                   ['service'] ==
//                                                               'Dressing Grooming'
//                                                           ? 'https://media.tenor.com/OgAGmSx8De8AAAAM/george-jetson-getting-dressed.gif'
//                                                           : controller.appList[index]
//                                                                       ['service'] ==
//                                                                   'Laundry'
//                                                               ? 'https://mir-s3-cdn-cf.behance.net/project_modules/hd/ed5a3179024277.5cbca8251c762.gif'
//                                                               : 'https://i.pinimg.com/originals/50/a8/57/50a857a7bbe36010c73c07792f1004f4.gif')),
//                           borderRadius: BorderRadius.circular(50),
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.2),
//                               spreadRadius: 2,
//                               blurRadius: 7,
//                               offset:
//                                   Offset(0, 3), // changes position of shadow
//                             ),
//                           ])),
//                 )
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class NewpersonPage extends StatelessWidget {
//   NewpersonPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController _controller = TextEditingController();
//     final HomeController homc = Get.put(HomeController());
//     return Scaffold(
//       body: SizedBox(
//         // height: MediaQuery.sizeOf(context).height+50,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Material(
//                   elevation: 10,
//                   borderRadius: BorderRadius.circular(13),
//                   color: const Color.fromARGB(255, 16, 142, 170),
//                   child: Padding(
//                     padding: const EdgeInsets.all(6.0),
//                     child: ClipPath(
//                       clipper: cl.MovieTicketClipper(),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               const Color.fromARGB(255, 60, 151, 95),
//                               const Color.fromARGB(255, 74, 195, 120),
//                               const Color.fromARGB(255, 60, 151, 95)
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                         ),
//                         // color: const Color.fromARGB(255, 19, 196, 81),
//                         child: Padding(
//                           padding: const EdgeInsets.all(18.0),
//                           child: Text(
//                             "May your actions today light up someone's path and make their journey a little brighter. Have a wonderful day dedicated to spreading kindness and positivity!.....",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 15,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                   )),
//             ),
//             GetBuilder<HomeController>(
//               builder: (controller) {
//                 return Container(
//                   height: 270,
//                   child: GridView.builder(
//                       shrinkWrap: true,
//                       itemCount: controller.servicesdb.length,
//                       scrollDirection: Axis.horizontal,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2, // Number of columns
//                           crossAxisSpacing: 1.0,
//                           mainAxisSpacing: 1.0,
//                           childAspectRatio: 0.6 / 1.1),
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () => controller.categorIndex(index),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Material(
//                               elevation: 10,
//                               borderRadius: BorderRadius.circular(13),
//                               color: controller.checkindex == index
//                                   ? const Color.fromARGB(255, 179, 213, 239)
//                                   : const Color.fromARGB(255, 245, 249, 250),
//                               child: ClipPath(
//                                 clipper: cl.WaveClipperOne(),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(13),
//                                     color: Colors.blue,
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         Colors.blue[
//                                             300]!, // Lighter shade of blue
//                                         Colors
//                                             .blue[700]!, // Darker shade of blue
//                                       ],
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight,
//                                     ),
//                                   ),
//                                   margin: EdgeInsets.all(8.0),
//                                   child: Center(
//                                       child: Text(
//                                     '${index == 0 ? 'All' : controller.servicesdb[index - 1]}',
//                                     style: TextStyle(color: Colors.white),
//                                   )),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                 );
//               },
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Text(
//                     'Personn Details',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(child: GetBuilder<HomeController>(
//               builder: (controller) {
//                 return
//                     // controller.islodin
//                     //     ? Center(
//                     //         child: CircularProgressIndicator(),
//                     //       )
//                     //     :
//                     ListView.builder(
//                   shrinkWrap: true,
//                   // physics: NeverScrollableScrollPhysics(),
//                   itemCount: controller.catergorypeople.length,
//                   itemBuilder: (context, index) {
//                     log('hh${controller.catergorypeople}');
//                     final person = controller.catergorypeople[index];
//                     log('${person['pic'].toString()}', name: 'img');
//                     return Skeletonizer(
//                       enabled: controller.islodin,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Material(
//                           color: const Color.fromARGB(255, 63, 181, 190),
//                           elevation: 10,
//                           borderRadius: BorderRadius.circular(13),
//                           child: ClipPath(
//                             clipper: cl.SideCutClipper(),
//                             child: Container(
//                               height: MediaQuery.sizeOf(context).height * 0.1,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(13),
//                                 color: Colors.blue,
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Colors.blue[300]!, // Lighter shade of blue
//                                     Colors.blue[700]!, // Darker shade of blue
//                                   ],
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                 ),
//                               ),
//                               child: ListTile(
//                                 leading: !person['pic']
//                                         .toString()
//                                         .contains('http')
//                                     ? SizedBox(
//                                         child: CircleAvatar(
//                                           backgroundColor: Colors.white,
//                                           child: Icon(Icons.person),
//                                         ),
//                                       )
//                                     : Image.network(person['pic'].toString()!),
//                                 title: Text(
//                                   person['name']!,
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                                 subtitle: Text(
//                                   'Age: ${person['age']}\nGender: ${person['gender']}',
//                                   style: TextStyle(
//                                     color: const Color.fromARGB(
//                                         255, 229, 229, 229),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:developer';

import 'package:carewe/home/home_contoller/home_controller.dart';
import 'package:carewe/person_add/view/person_add.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final HomeController homeController;

  @override
  void initState() {
    homeController = Get.put(HomeController());
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      log('Tab Index: ${_tabController.index}');
      if (_tabController.index == 0) {
        homeController.indexchange(_tabController.index);
        homeController.dutyFetch();
      } else {
        homeController.categorIndex(0);
      }
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
      backgroundColor: const Color(0xFFF5F7FA),
      floatingActionButton: GetBuilder<HomeController>(
        initState: (state) {
          homeController.dutyFetch();
        },
        builder: (controller) {
          return _tabController.index == 1
              ? FloatingActionButton(
                  backgroundColor: const Color(0xFF1E3A8A),
                  onPressed: () {
                    Get.to(UserDetailsForm());
                  },
                  child: const Icon(Icons.person_add, color: Colors.white),
                )
              : const SizedBox();
        },
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1E3A8A),
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600),
          tabs: const [
            Tab(
              icon: Icon(Icons.assignment_outlined),
              text: 'Duties',
            ),
            Tab(
              icon: Icon(Icons.people_outline),
              text: 'Persons',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          DutyDetailsTab(),
          NewPersonPage(),
        ],
      ),
    );
  }
}

class DutyDetailsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return controller.appList.isEmpty
            ? const Center(
                child: Text(
                  'No duties available',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: controller.appList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: _getGradientColors(
                              controller.appList[index]['service']),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: Image.network(
                                  _getServiceImage(
                                      controller.appList[index]['service']),
                                  height: 56,
                                  width: 56,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    Icons.medical_services_outlined,
                                    size: 30,
                                    color: Color(0xFF1E3A8A),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.appList[index]['service']!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildDetailRow(
                                    Icons.person_outline,
                                    'Client: ${controller.appList[index]['name']}',
                                  ),
                                  const SizedBox(height: 4),
                                  _buildDetailRow(
                                    Icons.people_outline,
                                    'Caregiver: ${controller.appList[index]['person']['name']}',
                                  ),
                                  const SizedBox(height: 4),
                                  _buildDetailRow(
                                    Icons.calendar_today_outlined,
                                    'Date: ${controller.appList[index]['date']}',
                                  ),
                                  const SizedBox(height: 4),
                                  _buildDetailRow(
                                    Icons.access_time_outlined,
                                    'Time: ${controller.appList[index]['time']}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white.withOpacity(0.9)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ),
      ],
    );
  }

  List<Color> _getGradientColors(String? service) {
    switch (service) {
      case 'Companionship':
        return [const Color(0xFF3949AB), const Color(0xFF1E3A8A)];
      case 'Shopping':
        return [const Color(0xFF4CAF50), const Color(0xFF2E7D32)];
      case 'Transportation':
        return [const Color(0xFF2196F3), const Color(0xFF0D47A1)];
      case 'Hospital Companion':
        return [const Color(0xFFE53935), const Color(0xFFB71C1C)];
      case 'Meal preparing':
        return [const Color(0xFFFF9800), const Color(0xFFE65100)];
      case 'Hygiene and Toileting':
        return [const Color(0xFF9C27B0), const Color(0xFF4A148C)];
      case 'Dressing Grooming':
        return [const Color(0xFF26A69A), const Color(0xFF00695C)];
      case 'Laundry':
        return [const Color(0xFF8D6E63), const Color(0xFF4E342E)];
      default:
        return [const Color(0xFF5C6BC0), const Color(0xFF3949AB)];
    }
  }

  String _getServiceImage(String? service) {
    switch (service) {
      case 'Companionship':
        return 'https://cdn.dribbble.com/userupload/23049293/file/original-e4a717f34789285589643bdda641506f.gif';
      case 'Shopping':
        return 'https://cdn.dribbble.com/userupload/21903715/file/original-2297feaec1ba5f6406c8694d0880aae9.gif';
      case 'Transportation':
        return 'https://cdn.dribbble.com/userupload/23154695/file/original-95c4f350244238203245af789ee5ba7e.gif';
      case 'Hospital Companion':
        return 'https://i.pinimg.com/originals/db/f3/c9/dbf3c92ca8525611209c7a5ac42405a3.gif';
      case 'Meal preparing':
        return 'https://cdn.dribbble.com/userupload/24942251/file/original-9c5cccaf493bcd4eec55b1835dfedc3d.gif';
      case 'Hygiene and Toileting':
        return 'https://i.gifer.com/O6cw.gif';
      case 'Dressing Grooming':
        return 'https://media.tenor.com/OgAGmSx8De8AAAAM/george-jetson-getting-dressed.gif';
      case 'Laundry':
        return 'https://mir-s3-cdn-cf.behance.net/project_modules/hd/ed5a3179024277.5cbca8251c762.gif';
      default:
        return 'https://i.pinimg.com/originals/50/a8/57/50a857a7bbe36010c73c07792f1004f4.gif';
    }
  }
}

class NewPersonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF26A69A),
                      Color(0xFF00897B),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Daily Inspiration",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "May your actions today light up someone's path and make their journey a little brighter. Have a wonderful day dedicated to spreading kindness and positivity!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Text(
              "Service Categories",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: GetBuilder<HomeController>(
              builder: (controller) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.servicesdb.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => controller.categorIndex(index),
                      child: Container(
                        width: 120,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 8),
                        decoration: BoxDecoration(
                          color: controller.checkindex == index
                              ? const Color(0xFF1E3A8A)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5,
                              spreadRadius: 0,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '${index == 0 ? 'All' : controller.servicesdb[index - 1]}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: controller.checkindex == index
                                  ? Colors.white
                                  : const Color(0xFF1E3A8A),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Personnel List',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<HomeController>(
              builder: (controller) {
                return controller.islodin
                    ? Skeletonizer(
                        enabled: true,
                        child: _buildPersonsList(controller),
                      )
                    : controller.catergorypeople.isEmpty
                        ? const Center(
                            child: Text(
                              'No personnel available for this category',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : _buildPersonsList(controller);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonsList(HomeController controller) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: controller.catergorypeople.length,
      itemBuilder: (context, index) {
        final person = controller.catergorypeople[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: const Color(0xFFE3F2FD),
              child: !person['pic'].toString().contains('http')
                  ? const Icon(Icons.person, color: Color(0xFF1E3A8A))
                  : ClipOval(
                      child: Image.network(
                        person['pic'].toString(),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.person,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                    ),
            ),
            title: Text(
              person['name']!,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPersonDetail(
                      Icons.cake_outlined, 'Age: ${person['age']}'),
                  const SizedBox(height: 2),
                  _buildPersonDetail(
                    person['gender'] == 'Male' ? Icons.male : Icons.female,
                    'Gender: ${person['gender']}',
                  ),
                ],
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }

  Widget _buildPersonDetail(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
