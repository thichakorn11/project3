import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class Delivery extends StatefulWidget {
  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  String name = '';
  String address = '';
  double amount = 0.0;
  String imagePath = '';
  File? selectedFile;

  void _submitForm() {
    print('ชื่อ: $name');
    print('ที่อยู่: $address');
    print('จำนวนเงิน: $amount');
    if (selectedFile != null) {
      print('ไฟล์ที่เลือก: ${selectedFile!.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แบบฟอร์มการจัดส่ง'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              // เพิ่มการทำงานเมื่อกดปุ่ม info ที่อยู่ข้างขวาบน
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ชื่อ',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'กรอกชื่อของคุณ',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'ที่อยู่จัดส่ง',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'กรอกที่อยู่จัดส่งของคุณ',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  address = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'จำนวนเงิน',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'กรอกจำนวนเงิน',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  amount = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                );
                if (result != null) {
                  selectedFile = File(result.files.single.path!);
                  setState(() {
                    imagePath = result.files.single.name;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_upload,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'เลือกไฟล์',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'ไฟล์ที่เลือก: $imagePath',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: _submitForm,
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                label: Text(
                  'ส่งข้อมูล',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
