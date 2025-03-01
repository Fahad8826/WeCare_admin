// import 'dart:developer';

// import 'package:carewe/home/home_contoller/home_controller.dart';
// import 'package:carewe/person_add/view/person_add.dart';
// import 'package:carewe/service_home/chat/model/chat_model.dart';
// import 'package:carewe/service_home/chat/view/chat_screen.dart';
// import 'package:carewe/service_home/home/widget/details.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'controller/servce_controller.dart';

// class ServiceHomePage extends StatefulWidget {
//   @override
//   State<ServiceHomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<ServiceHomePage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   // final HomeC = Get.put(HomeController());

//   @override
//   void initState() {
//     // HomeC=Get.put(HomeController());
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _tabController.addListener(() {
//       log('hil${_tabController.index}');

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
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         // floatingActionButton: GetBuilder<HomeController>(
//         //   initState: (state) {
//         //     HomeC.dutyFetch();
//         //   },
//         //   builder: (controller) {
//         //     log('${HomeC.index}');
//         //     return HomeC.index == 1
//         //         ? FloatingActionButton(
//         //             onPressed: () {
//         //               Get.to(UserDetailsForm());
//         //             },
//         //             child: Text('+'),
//         //           )
//         //         : SizedBox();
//         //   },
//         // ),
//         appBar: AppBar(
//           leading: IconButton(
//               onPressed: () => Get.back(),
//               icon: Icon(
//                 Icons.arrow_back_ios,
//                 color: Colors.white,
//               )),
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color.fromARGB(255, 15, 105, 135), // Light Blue
//                   Color.fromARGB(255, 47, 99, 168),
//                   Color.fromARGB(255, 38, 72, 98), // Pinkish Red
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.topRight,
//               ),
//             ),
//           ),
//           title: Text(
//             'Service login',
//             style: TextStyle(color: const Color.fromARGB(255, 227, 227, 227)),
//           ),
//           bottom: TabBar(
//             labelColor: const Color.fromARGB(255, 227, 227, 227),
//             unselectedLabelColor: const Color.fromARGB(255, 227, 227, 227),
//             onTap: (value) {
//               log('$value');
//               // HomeC.indexchange(value);
//               // HomeC.personDetailsFetch();
//               // HomeC.dutyFetch();
//             },
//             tabs: [
//               Tab(text: 'Duties'),
//               Tab(text: 'chat'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             ServiceDutyDetailsTab(),
//             ServiceChat(
//                 // homc: HomeC,
//                 ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ServiceDutyDetailsTab extends StatelessWidget {
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
//     final homC = Get.put(ServceController());
//     homC.fetchDuty();
//     return GetBuilder<ServceController>(
//       builder: (controller) {
//         return ListView.builder(
//           itemCount: controller.dutyList.length,
//           itemBuilder: (context, index) {
//             // final duty = duties[index];
//             return GestureDetector(
//               onTap: () {
//                 Get.to(DetailsPage(
//                   data: controller.dutyList[index],
//                 ));
//               },
//               child: Stack(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.amber,
//                         borderRadius: BorderRadius.circular(17),
//                         gradient: LinearGradient(
//                           colors: [
//                             Color(0xFF6A82FB), // Light Blue
//                             Color(0xFFFC5C7D)
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             spreadRadius: 2,
//                             blurRadius: 7,
//                             offset: Offset(0, 3), // changes position of shadow
//                           ),
//                         ],
//                       ),
//                       child: ListTile(
//                         // tileColor: const Color.fromARGB(255, 138, 200, 4),
//                         title: Text(controller.dutyList[index]['service']!,
//                             style: TextStyle(
//                                 color:
//                                     const Color.fromARGB(255, 247, 247, 247))),
//                         subtitle: Text(
//                             'Name: ${controller.dutyList[index]['name']}\nSelected Person: ${controller.dutyList[index]['person']['name']}\nDate: ${controller.dutyList[index]['date']}\nTime: ${controller.dutyList[index]['time']}',
//                             style: TextStyle(
//                                 color:
//                                     const Color.fromARGB(255, 219, 219, 219))),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 18,
//                     right: 10,
//                     child: Container(
//                         height: 100,
//                         width: 100,
//                         decoration: BoxDecoration(
//                             image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: NetworkImage(controller.dutyList[index]
//                                             ['service'] ==
//                                         'Companionship'
//                                     ? 'https://cdn.dribbble.com/userupload/23049293/file/original-e4a717f34789285589643bdda641506f.gif'
//                                     : controller.dutyList[index]['service'] ==
//                                             'Shopping'
//                                         ? 'https://cdn.dribbble.com/userupload/21903715/file/original-2297feaec1ba5f6406c8694d0880aae9.gif'
//                                         : controller.dutyList[index]['service'] ==
//                                                 'Transportation'
//                                             ? 'https://cdn.dribbble.com/userupload/23154695/file/original-95c4f350244238203245af789ee5ba7e.gif'
//                                             : controller.dutyList[index]
//                                                         ['service'] ==
//                                                     'Hospital Companion'
//                                                 ? 'https://i.pinimg.com/originals/db/f3/c9/dbf3c92ca8525611209c7a5ac42405a3.gif'
//                                                 : controller.dutyList[index]
//                                                             ['service'] ==
//                                                         'Meal preparing'
//                                                     ? 'https://cdn.dribbble.com/userupload/24942251/file/original-9c5cccaf493bcd4eec55b1835dfedc3d.gif'
//                                                     : controller.dutyList[index]
//                                                                 ['service'] ==
//                                                             'Hygiene and Toileting'
//                                                         ? 'https://i.gifer.com/O6cw.gif'
//                                                         : controller.dutyList[index]['service'] ==
//                                                                 'Dressing Grooming'
//                                                             ? 'https://media.tenor.com/OgAGmSx8De8AAAAM/george-jetson-getting-dressed.gif'
//                                                             : controller.dutyList[index]
//                                                                         ['service'] ==
//                                                                     'Laundry'
//                                                                 ? 'https://mir-s3-cdn-cf.behance.net/project_modules/hd/ed5a3179024277.5cbca8251c762.gif'
//                                                                 : 'https://i.pinimg.com/originals/50/a8/57/50a857a7bbe36010c73c07792f1004f4.gif')),
//                             borderRadius: BorderRadius.circular(50),
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.2),
//                                 spreadRadius: 2,
//                                 blurRadius: 7,
//                                 offset:
//                                     Offset(0, 3), // changes position of shadow
//                               ),
//                             ])),
//                   )
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class ServiceChat extends StatelessWidget {
//   // final HomeController homc;
//   List<ChatModel> dummyData = [
//     ChatModel(
//       name: "John Doe",
//       message: "Hey, how are you?",
//       time: "15:30",
//       avatarUrl: "https://via.placeholder.com/150",
//     ),
//     ChatModel(
//       name: "Jane Smith",
//       message: "Let's meet tomorrow.",
//       time: "14:30",
//       avatarUrl: "https://via.placeholder.com/150",
//     ),
//     ChatModel(
//       name: "Sam Wilson",
//       message: "Got the documents.",
//       time: "13:45",
//       avatarUrl: "https://via.placeholder.com/150",
//     ),
//   ];
//   // Add more sample data as needed

//   @override
//   Widget build(BuildContext context) {
//     final servC = Get.put(ServceController());
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Chats'),
//       // ),
//       body: GetBuilder<ServceController>(
//         initState: (state) {
//           servC.fetchChat();
//         },
//         builder: (controller) {
//           return ListView.builder(
//             itemCount: controller.dutyChat.length,
//             itemBuilder: (context, index) {
//               var chat = dummyData[index];
//               return GestureDetector(
//                 onTap: () {
//                   Get.to(ChatScreen(
//                     email: controller.dutyChat.keys.toList()[index],
//                     id: 'rahul@456',
//                   ));
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Material(
//                     borderRadius: BorderRadius.circular(13),
//                     color: Colors.white,
//                     elevation: 10,
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(
//                             'https://static.vecteezy.com/system/resources/thumbnails/006/487/917/small_2x/man-avatar-icon-free-vector.jpg'),
//                       ),
//                       title: Text('${controller.emailString[index]}'),
//                       subtitle: Text(
//                           '${(controller.dutyChat.values.toList()[index] as List).last['message']}'),
//                       trailing: Text(
//                           '${(controller.dutyChat.values.toList()[index] as List).last['time']}'
//                               .toString()
//                               .substring(11, 19)),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:carewe/service_home/chat/view/chat_screen.dart';
import 'package:carewe/service_home/home/widget/details.dart';

import 'controller/servce_controller.dart';

// Constants for consistent styling
class AppTheme {
  static const Color primaryColor = Color(0xFF1976D2);
  static const Color secondaryColor = Color(0xFF03A9F4);
  static const Color accentColor = Color(0xFF0D47A1);
  static const Color textPrimaryColor = Color(0xFF212121);
  static const Color textSecondaryColor = Color(0xFF757575);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Colors.white;

  static const double borderRadius = 15.0;
  static const double elementSpacing = 16.0;
  static const double cardElevation = 4.0;

  static BoxShadow defaultShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    spreadRadius: 1,
    blurRadius: 5,
    offset: Offset(0, 2),
  );

  static TextStyle titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle subtitleStyle = TextStyle(
    fontSize: 14,
    color: Colors.white.withOpacity(0.9),
  );
}

class ServiceHomePage extends StatefulWidget {
  @override
  State<ServiceHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<ServiceHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      log('Current Tab Index: ${_tabController.index}');
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              const Color.fromARGB(255, 87, 25, 117),
              const Color.fromARGB(235, 0, 0, 0)
            ])),
          ),
          title: Text(
            'Service Dashboard',
            style: AppTheme.titleStyle,
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withOpacity(0.7),
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            tabs: [
              Tab(
                icon: Icon(Icons.assignment),
                text: 'Duties',
              ),
              Tab(
                icon: Icon(Icons.chat),
                text: 'Messages',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ServiceDutyDetailsTab(),
            ServiceChat(),
          ],
        ),
      ),
    );
  }
}

class ServiceDutyDetailsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homC = Get.put(ServceController());
    homC.fetchDuty();

    return GetBuilder<ServceController>(
      builder: (controller) {
        return controller.dutyList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.assignment_outlined,
                      size: 64,
                      color: AppTheme.primaryColor.withOpacity(0.5),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No duties assigned yet',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(AppTheme.elementSpacing),
                itemCount: controller.dutyList.length,
                itemBuilder: (context, index) {
                  final service = controller.dutyList[index]['service'] ?? '';

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(DetailsPage(
                          data: controller.dutyList[index],
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppTheme.borderRadius),
                          color: AppTheme.cardColor,
                          boxShadow: [AppTheme.defaultShadow],
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color.fromARGB(255, 87, 25, 117),
                                    Colors.black
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft:
                                      Radius.circular(AppTheme.borderRadius),
                                  topRight:
                                      Radius.circular(AppTheme.borderRadius),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              child: Row(
                                children: [
                                  Icon(
                                    _getServiceIcon(service),
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      service,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildInfoRow(
                                          Icons.person,
                                          'Client',
                                          controller.dutyList[index]['name'] ??
                                              'N/A',
                                        ),
                                        SizedBox(height: 8),
                                        _buildInfoRow(
                                          Icons.person_outline,
                                          'Care Recipient',
                                          controller.dutyList[index]['person']
                                                  ['name'] ??
                                              'N/A',
                                        ),
                                        SizedBox(height: 8),
                                        _buildInfoRow(
                                          Icons.calendar_today,
                                          'Date',
                                          controller.dutyList[index]['date'] ??
                                              'N/A',
                                        ),
                                        SizedBox(height: 8),
                                        _buildInfoRow(
                                          Icons.access_time,
                                          'Time',
                                          controller.dutyList[index]['time'] ??
                                              'N/A',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 4,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          _getServiceImageUrl(service),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: AppTheme.primaryColor,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondaryColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getServiceIcon(String service) {
    switch (service) {
      case 'Companionship':
        return Icons.people;
      case 'Shopping':
        return Icons.shopping_cart;
      case 'Transportation':
        return Icons.directions_car;
      case 'Hospital Companion':
        return Icons.local_hospital;
      case 'Meal preparing':
        return Icons.restaurant;
      case 'Hygiene and Toileting':
        return Icons.clean_hands;
      case 'Dressing Grooming':
        return Icons.face;
      case 'Laundry':
        return Icons.local_laundry_service;
      default:
        return Icons.miscellaneous_services;
    }
  }

  String _getServiceImageUrl(String service) {
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

class ServiceChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final servC = Get.put(ServceController());

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: GetBuilder<ServceController>(
        initState: (state) {
          servC.fetchChat();
        },
        builder: (controller) {
          return controller.dutyChat.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 64,
                        color: AppTheme.primaryColor.withOpacity(0.5),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No messages yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppTheme.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(AppTheme.elementSpacing),
                  itemCount: controller.dutyChat.length,
                  itemBuilder: (context, index) {
                    final email = controller.emailString[index];
                    final latestMessage =
                        (controller.dutyChat.values.toList()[index] as List)
                            .last;
                    final messageText = latestMessage['message'] ?? '';
                    final messageTime = latestMessage['time'] ?? '';

                    String formattedTime = '';
                    if (messageTime.toString().length > 11) {
                      formattedTime = messageTime.toString().substring(11, 19);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(ChatScreen(
                            email: controller.dutyChat.keys.toList()[index],
                            id: 'rahul@456',
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppTheme.borderRadius),
                            color: AppTheme.cardColor,
                            boxShadow: [AppTheme.defaultShadow],
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(12),
                            leading: CircleAvatar(
                              radius: 24,
                              backgroundColor:
                                  AppTheme.primaryColor.withOpacity(0.2),
                              backgroundImage: NetworkImage(
                                'https://static.vecteezy.com/system/resources/thumbnails/006/487/917/small_2x/man-avatar-icon-free-vector.jpg',
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    email,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textPrimaryColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  formattedTime,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textSecondaryColor,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                messageText,
                                style: TextStyle(
                                  color: AppTheme.textSecondaryColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
