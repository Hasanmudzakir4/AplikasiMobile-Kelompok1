import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({Key? key}) : super(key: key);

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  bool isExpense = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              child: Column(
                children: [
                  Lottie.asset(
                    'images/animation.json',
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ListTile(
                    title: Center(
                      child: Text(
                        "Features in progress...",
                        style: GoogleFonts.ephesis(
                            fontSize: 40.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ], // Added closing bracket for the 'children' list
              ),
            ),
          ),
        ),
      ),
    );
  }
}
