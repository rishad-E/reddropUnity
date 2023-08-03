import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateUserScreen extends StatefulWidget {
  const UpdateUserScreen({super.key});

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
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
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    nameController.text = args['Name'];
    phoneController.text = args['Phone'];
    selected = args['BGroup'];
    final docId = args['id'];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Donor',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
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
              value: selected,
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
          updateDonor(docId);
          const snackdemo = SnackBar(
            content: Text('Updated Successfully'),
            backgroundColor: Colors.green,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackdemo);
        },
        tooltip: 'Update Details',
        child: const Icon(
          Icons.save_as_outlined,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void updateDonor(docId) {
    final data = {
      'Name': nameController.text,
      'Phone': phoneController.text,
      'BGroup': selected
    };

    donor.doc(docId).update(data).then((value) => Navigator.pop(context));
  }
}
