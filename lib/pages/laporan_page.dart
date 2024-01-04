import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  bool isExpense = true;

  void openDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Center(
                  child: Column(
                children: [
                  Text(
                    (isExpense) ? "Add Expense" : "Add Income",
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: (isExpense) ? Colors.red : Colors.green),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: "Name"),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("Save")),
                ],
              )),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Laporan')),
        body: Center(
          child: Text(
            "Coming Soon",
            style: GoogleFonts.ephesis(
                fontSize: 35.0, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
