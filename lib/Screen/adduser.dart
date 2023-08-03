import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final bloodGroups = [
    'A +ve',
    'A -ve',
    'B +ve',
    'B -ve',
    'O +ve',
    'O -ve',
    'AB +ve',
    'AB -ve'
  ];
  String? selected;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final CollectionReference donor =
      FirebaseFirestore.instance.collection('Donor');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: const Text(
          'Add Donor',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {Navigator.pop(context);},
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  label: const Text('Donor Name'),
                  labelStyle: TextStyle(color: Colors.grey.shade400)),
              controller: nameController,
            ),
            const SizedBox(height: 15),
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  label: const Text('Donor Number'),
                  labelStyle: TextStyle(color: Colors.grey.shade400)),
              controller: phoneController,
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField(
              decoration: InputDecoration(
                  label: const Text("select blood group"),
                  labelStyle: TextStyle(color: Colors.grey.shade400),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              items: bloodGroups
                  .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item,
                          style: const TextStyle(color: Colors.black54))))
                  .toList(),
              onChanged: (val) {
                selected = val;
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 236, 95, 85),
        onPressed: () {
          addDonor();
          const snackdemo = SnackBar(
            content: Text('Donor added Successfully'),
            backgroundColor: Colors.green,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackdemo);
          Navigator.pop(context);
        },
        tooltip: 'Save Details',
        child: const Icon(
          Icons.save_as_outlined,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void addDonor() {
    final data = {
      'Name': nameController.text,
      'Phone': phoneController.text,
      'BGroup': selected
    };
    donor.add(data);
  }
}
