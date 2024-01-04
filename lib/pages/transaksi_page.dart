// ignore_for_file: sized_box_for_whitespace
import 'package:firebase_crud/services/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class Transaksi extends StatefulWidget {
  const Transaksi({super.key});

  @override
  State<Transaksi> createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  TextEditingController ammountController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final _checkInsertUpdate = "Add Transaksi";

  bool isExpense = true;

  List<String> categoryList = ['Select a category', 'Income', 'Expense'];

  List<String> list = [
    'Select a notes',
    'Makan dan Jajan',
    'Transportasi',
    'Hiburan',
    'Gaji'
  ];
  late String categoryDropDownValue = categoryList.first;
  late String dropDownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text(
              _checkInsertUpdate,
            )),
        body: SingleChildScrollView(
            child: SafeArea(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                  child: Column(
                children: [
                  TextFormField(
                    controller: ammountController,
                    decoration: InputDecoration(
                      labelText: 'Ammount',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      suffixIcon: GestureDetector(
                        child: Icon(
                          Icons.attach_money_sharp,
                          color: Colors.blue, // Icon kalender
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  DropdownButtonFormField<String>(
                    value: dropDownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropDownValue = newValue!;
                        notesController.text = newValue;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Notes',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == 'Select a notes') {
                        return 'Please select a notes';
                      }
                      return null;
                    },
                    hint: Text('Select a notes'), // Use this to provide a hint
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  DropdownButtonFormField<String>(
                    value: categoryDropDownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        categoryDropDownValue = newValue!;
                        categoryController.text = newValue;
                      });
                    },
                    items: categoryList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == 'Select a category') {
                        return 'Please select a category';
                      }
                      return null;
                    },
                    hint:
                        Text('Select a category'), // Use this to provide a hint
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: dateController,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: GestureDetector(
                        child: Icon(
                          Icons.calendar_month,
                          color: Colors.blue, // Icon kalender
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2099),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            dateController.text = formattedDate;
                          }
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Date';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      suffixIcon: GestureDetector(
                        child: Icon(
                          Icons.assignment,
                          color: Colors.blue, // Icon kalender
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async { 
                        String id = randomAlphaNumeric(10);
                        Map<String, dynamic> employeeInfoMap = {
                          "Id": id,
                          "Ammount": ammountController.text,
                          "Notes": notesController.text,
                          "Category": categoryController.text,
                          "Date": dateController.text,
                          "Description": descriptionController.text,
                        };
                        await DatabaseMethods()
                            .addEmployeeDetails(employeeInfoMap, id)
                            .then((value) {
                          Fluttertoast.showToast(
                              msg: "Upload Succesfuly!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 15.0);
                          ammountController.text = "";
                          notesController.text = categoryDropDownValue;
                          categoryController.text = dropDownValue;
                          dateController.text = "";
                          descriptionController.text = "";
                        });
                      },
                      child: Text("Save"),
                    ),
                  )
                ],
              )),
            ),
          ],
        ))));
  }
}
