import 'package:flutter/material.dart';

import 'global.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String userName = '';
  String userEmail = '';
  String userRegion = '';

  bool isSwtiched = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      final data = await sqlDb
          .readData("SELECT * FROM Users WHERE id = ${Global.currentId}");
      setState(() {
        userName = data[0]['username'];
        userEmail = data[0]['email'];
        userRegion = data[0]['region'];
      });
    } catch (e) {
      print("Database error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Account",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                fontSize: 28)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(40),
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('assets/images/pfp4.jpg')),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                userName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Poppins'),
              ),
              Text(
                userEmail,
                style: const TextStyle(fontFamily: 'Poppins'),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 216, 0, 1),
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color.fromRGBO(15, 34, 165, 0.1)),
                  child: const Icon(
                    Icons.settings_outlined,
                    color: Color.fromRGBO(15, 34, 165, 1),
                  ),
                ),
                title: const Text(
                  "Settings",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                    size: 25.0,
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color.fromRGBO(15, 34, 165, 0.1)),
                  child: const Icon(
                    Icons.translate,
                    color: Color.fromRGBO(15, 34, 165, 1),
                  ),
                ),
                title: const Text(
                  "Language",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                    size: 25.0,
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color.fromRGBO(15, 34, 165, 0.1)),
                  child: const Icon(
                    Icons.nightlight_outlined,
                    color: Color.fromRGBO(15, 34, 165, 1),
                  ),
                ),
                title: const Text(
                  "Dark mode",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                trailing: SizedBox(
                  width: 30,
                  height: 30,
                  child: Switch(
                    value: isSwtiched,
                    onChanged: (value) {
                      setState(
                        () {
                          isSwtiched = value;
                        },
                      );
                    },
                    activeColor: const Color.fromRGBO(15, 34, 165, 1),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1.0,
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color.fromRGBO(15, 34, 165, 0.1)),
                  child: const Icon(
                    Icons.door_back_door_outlined,
                    color: Color.fromRGBO(15, 34, 165, 1),
                  ),
                ),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                    size: 25.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
