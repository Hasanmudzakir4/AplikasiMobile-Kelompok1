// // ignore_for_file: avoid_unnecessary_containers

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_crud/services/database.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Histories extends StatefulWidget {
//   const Histories({super.key});

//   @override
//   State<Histories> createState() => _HistoriesState();
// }

// class _HistoriesState extends State<Histories> {
//   TextEditingController ammountController = TextEditingController();
//   TextEditingController notesController = TextEditingController();
//   TextEditingController categoryController = TextEditingController();
//   TextEditingController dateController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();

//   final user = FirebaseAuth.instance.currentUser;
//   bool isExpense = true;

//   Stream? employeeStream;

//   getontheload() async {
//     employeeStream = await DatabaseMethods(). employeeStream = await DatabaseMethods().getEmployeeDetails(
//       category: isExpense ? 'Expense' : 'Income',
//     );
//   }

//   Widget allEmployeeDetails() {
//     return StreamBuilder(
//       stream: employeeStream,
//       builder: (context, AsyncSnapshot snapshot) {
//         if (snapshot.hasData) {
//           return ListView.builder(
//             itemCount: snapshot.data.docs.length,
//             itemBuilder: (context, index) {
//               DocumentSnapshot ds = snapshot.data.docs[index];
//               return Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Card(
//                   elevation: 10,
//                   child: ListTile(
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         GestureDetector(
//                             onTap: () {
//                               ammountController.text = ds["Ammount"];
//                               notesController.text = ds["Notes"];
//                               categoryController.text = ds["Category"];
//                               dateController.text = ds["Date"];
//                               descriptionController.text = ds["Description"];
//                               updateEmployeeDetails(ds["Id"]);
//                             },
//                             child: Icon(Icons.remove_red_eye)),
//                         SizedBox(
//                           width: 12,
//                         ),
//                         Icon(Icons.edit),
//                         SizedBox(
//                           width: 12,
//                         ),
//                         GestureDetector(
//                             onTap: () async {
//                               await DatabaseMethods()
//                                   .deleteEmployeeDetails(ds["Id"]);
//                             },
//                             child: Icon(Icons.delete)),
//                       ],
//                     ),
//                     title: Text(ds["Ammount"]),
//                     subtitle: Text(ds["Notes"]),
//                     leading: (isExpense)
//                         ? Icon(Icons.upload, color: Colors.red)
//                         : Icon(Icons.download, color: Colors.green),
//                   ),
//                 ),
//               );
//             },
//           );
//         } else {
//           return Container();
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Histories')),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(5),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Switch(
//                     value: isExpense,
//                     onChanged: (bool value) {
//                       setState(() {
//                         isExpense = value;
//                       });
//                     },
//                     inactiveTrackColor: Colors.green[200],
//                     inactiveThumbColor: Colors.green,
//                     activeColor: Colors.red,
//                   ),
//                   Text(
//                     isExpense ? 'Expense' : 'Income',
//                     style: GoogleFonts.montserrat(fontSize: 14),
//                   ),
//                 ],
//               ),
//               Expanded(child: allEmployeeDetails()),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future updateEmployeeDetails(String id) => showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//             content: Container(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: Icon(Icons.cancel)),
//                       SizedBox(
//                         width: 60.0,
//                       ),
//                       Text(
//                         "Update",
//                         style: TextStyle(
//                             color: Colors.blue,
//                             fontSize: 24.0,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         "Employee",
//                         style: TextStyle(
//                           color: Colors.yellow,
//                           fontSize: 24.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   Text(
//                     "Name",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(left: 10.0),
//                     decoration: BoxDecoration(
//                         border: Border.all(),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: TextField(
//                       controller: ammountController,
//                       decoration: InputDecoration(border: InputBorder.none),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Text(
//                     "Age",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(left: 10.0),
//                     decoration: BoxDecoration(
//                         border: Border.all(),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: TextField(
//                       controller: notesController,
//                       decoration: InputDecoration(border: InputBorder.none),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Text(
//                     "Location",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(left: 10.0),
//                     decoration: BoxDecoration(
//                         border: Border.all(),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: TextField(
//                       controller: categoryController,
//                       decoration: InputDecoration(border: InputBorder.none),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30.0,
//                   ),
//                   Center(
//                       child: ElevatedButton(
//                           onPressed: () async {
//                             Map<String, dynamic> updateInfo = {
//                               "Ammount": ammountController.text,
//                               "Notes": notesController.text,
//                               "Id": id,
//                               "Category": categoryController.text
//                             };
//                             await DatabaseMethods()
//                                 .updateEmployeeDetails(id, updateInfo)
//                                 .then((value) {
//                               Navigator.pop(context);
//                             });
//                           },
//                           child: Text("Update")))
//                 ],
//               ),
//             ),
//           ));
// }
