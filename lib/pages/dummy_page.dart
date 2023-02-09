// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:lms_parent_app/login/login_apiservice.dart';

// class DummyPage extends StatefulWidget {
//   const DummyPage({super.key});

//   @override
//   State<DummyPage> createState() => _DummyPageState();
// }

// class _DummyPageState extends State<DummyPage> {
//   @override
//   void initState() {
//     super.initState();
//     Intilizize();
//     print("Hello");
//   }

//   String number = '';
//   List numbersContacts = [];

//   void Intilizize() async {
//     await fetchAlbum().then((value) {
//       print(value);
//       setState(() {
//         numbersContacts = value;
//         print(numbersContacts);
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Dummy"),
//       ),
//       body: SingleChildScrollView(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               for (int i = 0; i < numbersContacts.length; i++)
//                 Text("hello  ${numbersContacts[i]['mobileNo']}")
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
