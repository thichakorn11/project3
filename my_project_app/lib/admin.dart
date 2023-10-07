import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'app_config.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  List<dynamic> adminData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final response = await http.get(
        Uri.parse("${AppConfig.SERVICE_URL}/api/admin"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString("access_token")}'
        },
      );

      final json = jsonDecode(response.body);

      print(json["data"]);

      if (json["result"] == true) {
        setState(() {
          adminData = List.from(json["data"]);
        });
      } else {
        // แสดงข้อความหรือกระทบอื่น ๆ เมื่อมีข้อผิดพลาด
        print("มีข้อผิดพลาด: ${json['message']}");
        // เพิ่มบรรทัดนี้เพื่อตั้งค่า customerData เป็นรายการว่างเมื่อมีข้อผิดพลาด
        adminData = [];
      }
    } catch (e) {
      // แสดงข้อความข้อผิดพลาดเมื่อเกิดข้อผิดพลาด
      print("เกิดข้อผิดพลาด: $e");
    }
  }

  Widget buildAdminList() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0), // Adjust the top padding as needed
      child: ListView.builder(
        itemCount: adminData.length,
        itemBuilder: (context, index) {
          var admin = adminData[index];
          return Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: CircleAvatar(
                // backgroundColor: const Color(0xff6ae792),
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 24, // Adjust the icon size as needed
                ),
              ),
              title: Text(admin["name"]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(admin["address"]),
                  // Text("เบอร์โทร: ${customer["tel"]}"), // เพิ่มเบอร์โทร
                  // Text("อีเมล: ${customer["email"]}"), // เพิ่มอีเมล
                ],
              ),
              trailing: Icon(Icons.edit),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //        AdminDetailScreen(admin: admin),
                //   ),
                // );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ข้อมูลพนักงาน"),
        backgroundColor: Colors.red,
      ),
      body: Container(
        color: const Color(0xFFFFDCDF),
        child: buildAdminList(),
      ),
    );
  }
}
