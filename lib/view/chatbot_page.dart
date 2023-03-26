// import 'package:ecom/Model/message.dart';
// import 'package:ecom/view/templates/templates.dart';
// import 'package:ecom/viewmodel.dart';
// import 'package:ecom/viewmodel_impl.dart';
// import 'package:flutter/material.dart';

// class ChatBotPage extends StatefulWidget {
//   final String username;
//   ChatBotPage({super.key, required this.username});

//   @override
//   State<ChatBotPage> createState() => _ChatBotPageState(username);
// }

// class _ChatBotPageState extends State<ChatBotPage>
//     with TickerProviderStateMixin {
//   String username;
//   late List<Message> messages;

//   TextEditingController _question = TextEditingController();
  
//   ViewModel vm = ViewModelImpl();
  
//   _ChatBotPageState(this.username) {
//     messages = List.empty();
//     _getMessages();
//   }

//   _getMessages() async {
//     var msg = await vm.getMessages(username);
//     setState(() {
//       messages = msg;
//     });
//   }

// @override
//   void dispose() {
//     _question.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBarWithBackButton(),
//       body: ListView(
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height - 200,
//             child: ListView.builder(
//               padding: const EdgeInsets.all(15),
//               itemBuilder: (BuildContext context, int index) {
//                 return message(messages[index].content, messages[index].sender == "user" ? 1 : 0);
//               },
//               itemCount: messages.length,
//             ),
//           ),
//           SizedBox(
//             height: 40,
//             child: labelledTextField("type you question", _question),
//           ),
//           IconButton(
//               onPressed: () => _chatbotQuery(_question.text), icon: Icon(Icons.forward)),
//         ],
//       ),
//     );
//   }

//   Future<void> _chatbotQuery(String question) async {
//     setState(() {
//       messages.add(Message("user", question));
//     });
//     String response = await vm.chatbotQuery(question);
//     setState(() {
//           messages.add(Message("bot", response));

//     });
//     return;
//   }
// }
