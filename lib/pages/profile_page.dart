// ignore_for_file: sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoggingOut = false;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffffffff),
      child: ListView(
        padding: EdgeInsets.all(12),
        physics: BouncingScrollPhysics(),
        children: [
          Container(height: 35),
          userTile(),
          divider(),
          colorTiles(),
          divider(),
          bwTiles(),
        ],
      ),
    );
  }

  Widget userTile() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage("images/avatar.webp"),
      ),
      title: Text(
        (user!.email.toString()),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('Software Engineer'),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Divider(
        thickness: 1.5,
      ),
    );
  }

  Widget colorTiles() {
    return Column(
      children: [
        colorTile(
          Icons.person_outline,
          Colors.deepPurple,
          "Personal Data",
          () {},
        ),
        colorTile(
          Icons.settings_outlined,
          Colors.blue,
          "Settings",
          () {},
        ),
        colorTile(
          Icons.credit_card,
          Colors.pink,
          "Payment",
          () {},
        ),
        colorTile(
          Icons.favorite_border,
          Colors.orange,
          "Favorites",
          () {},
        ),
      ],
    );
  }

  Widget colorTile(
    IconData icon,
    Color color,
    String text,
    VoidCallback onPressed, {
    bool blackAndWhite = false,
  }) {
    return ListTile(
      leading: Container(
        child: Icon(
          icon,
          color: color,
        ),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: color.withOpacity(0.09),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      title: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
      onTap: onPressed,
    );
  }

  Widget bwTiles() {
    return Column(
      children: [
        bwTile(Icons.info_outline, "FAQs", () {}),
        bwTile(Icons.border_color_outlined, "Handbook", () {}),
        bwTile(Icons.textsms_outlined, "Community", () {}),
        bwTile(
          Icons.logout_outlined,
          "Logout",
          () {
            _showLogoutConfirmationDialog();
          },
        ),
      ],
    );
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Are you sure want to logout?',
            style: TextStyle(fontSize: 20),
          ),
          content: isLoggingOut
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : null,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                // Set isLoggingOut to true to show loading indicator
                setState(() {
                  isLoggingOut = true;
                });

                // Perform logout
                await FirebaseAuth.instance.signOut();

                // Set isLoggingOut back to false after logout is complete
                setState(() {
                  isLoggingOut = false;
                });

                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Widget bwTile(IconData icon, String text, VoidCallback onPressed) {
    return ListTile(
      leading: Container(
        child: Icon(
          icon,
          color: Colors.black,
        ),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.09),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      title: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
      onTap: onPressed,
    );
  }
}
