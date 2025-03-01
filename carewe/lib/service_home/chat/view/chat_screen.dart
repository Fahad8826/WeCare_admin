// import 'package:carewe/service_home/chat/controller/chat_controller.dart';
// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// class ChatScreen extends StatefulWidget {
//   final String id;
//   final String email;

//   const ChatScreen({super.key, required this.id, required this.email});
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final List<Map<String, dynamic>> _messages = [];
//   final TextEditingController _controller = TextEditingController();
//   final chatC = Get.put(ChatController());
//   void _sendMessage() {
//     if (_controller.text.trim().isEmpty) return;
//     chatC.sendMessage(widget.id, _controller.text, widget.email);
//     _controller.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 5,
//         backgroundColor: const Color.fromARGB(255, 31, 76, 113),
//         leading: IconButton(
//             onPressed: () => Get.back(),
//             icon: Icon(
//               Icons.arrow_back_ios,
//               color: Colors.white,
//             )),
//         title: Text(
//           'Chat Screen',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: GetBuilder<ChatController>(
//         initState: (state) {
//           chatC.fetchMessages(widget.id, widget.email);
//         },
//         builder: (controller) {
//           return Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   reverse: true,
//                   itemCount: controller.messages.length,
//                   itemBuilder: (context, index) {
//                     final message = controller
//                         .messages[controller.messages.length - 1 - index];
//                     return Align(
//                       alignment: message['isUser']
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft,
//                       child: Container(
//                         width: MediaQuery.sizeOf(context).width * 0.3,
//                         margin:
//                             EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: message['isUser']
//                               ? Colors.blueAccent
//                               : Colors.grey[300],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Text(
//                           message['message'],
//                           style: TextStyle(
//                             color: message['isUser']
//                                 ? Colors.white
//                                 : Colors.black87,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Material(
//                   elevation: 10,
//                   borderRadius: BorderRadius.circular(13),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             controller: _controller,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                   borderSide: BorderSide(strokeAlign: 0,
//                                       color: const Color.fromARGB(
//                                           255, 149, 60, 33))),
//                               hintText: 'Type a message',
//                             ),
//                             onSubmitted: (value) => _sendMessage(),
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.send),
//                           onPressed: _sendMessage,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 8,
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:carewe/service_home/chat/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  final String id;
  final String email;

  const ChatScreen({super.key, required this.id, required this.email});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final chatC = Get.put(ChatController());

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    chatC.sendMessage(widget.id, _controller.text, widget.email);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 31, 76, 113),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Text(
                widget.email.isNotEmpty ? widget.email[0].toUpperCase() : 'C',
                style: const TextStyle(
                  color: Color.fromARGB(255, 31, 76, 113),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Chat Screen',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[100], // Subtle background color
        child: GetBuilder<ChatController>(
          initState: (state) {
            chatC.fetchMessages(widget.id, widget.email);
          },
          builder: (controller) {
            return Column(
              children: [
                Expanded(
                  child: controller.messages.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                size: 48,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No messages yet',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          reverse: true,
                          itemCount: controller.messages.length,
                          padding: const EdgeInsets.all(12),
                          itemBuilder: (context, index) {
                            final message = controller.messages[
                                controller.messages.length - 1 - index];
                            final isUser = message['isUser'];

                            return Align(
                              alignment: isUser
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.75,
                                ),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 8),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 14),
                                decoration: BoxDecoration(
                                  color: isUser
                                      ? const Color.fromARGB(255, 31, 76, 113)
                                      : Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(16),
                                    topRight: const Radius.circular(16),
                                    bottomLeft: isUser
                                        ? const Radius.circular(16)
                                        : Radius.zero,
                                    bottomRight: isUser
                                        ? Radius.zero
                                        : const Radius.circular(16),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 3,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  message['message'],
                                  style: TextStyle(
                                    color:
                                        isUser ? Colors.white : Colors.black87,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              hintText: 'Type a message',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (value) => _sendMessage(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 31, 76, 113),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: _sendMessage,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            );
          },
        ),
      ),
    );
  }
}
