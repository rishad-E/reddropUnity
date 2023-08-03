import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('Donor');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blood Donation App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.red,
        // elevation: 5,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 236, 95, 85),
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        tooltip: 'Add Donor',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      body: StreamBuilder(
        stream: donor.orderBy('Name').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text("No data"));
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                final DocumentSnapshot donorSnap = snapshot.data?.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10,
                              )
                        ]),
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.redAccent,
                            child: Text(
                              donorSnap['BGroup'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(donorSnap['Name'],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            Text(donorSnap['Phone'].toString()),
                          ],
                        ),
                        const SizedBox(width:15),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/update',arguments: {
                                    'Name':donorSnap['Name'],
                                    'Phone':donorSnap['Phone'].toString(),
                                    'BGroup':donorSnap['BGroup'],
                                    'id':donorSnap.id
                                  });
                                },
                                icon: const Icon(Icons.edit_document)),
                            IconButton(
                                onPressed: () {
                                  deleteDonor(donorSnap.id);

                                },
                                icon: const Icon(Icons.delete_outlined))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: snapshot.data?.docs.length,
            );
          }
        },
      ),
    );
  }
  void deleteDonor(docId){
    donor.doc(docId).delete();
  }
}
