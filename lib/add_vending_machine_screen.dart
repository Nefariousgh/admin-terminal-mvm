import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddVendingMachineScreen extends StatefulWidget {
  @override
  _AddVendingMachineScreenState createState() => _AddVendingMachineScreenState();
}

class _AddVendingMachineScreenState extends State<AddVendingMachineScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Vending Machine'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Machine Name'),
            ),
            TextFormField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Machine Location'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance.collection('vending_machines').add({
                  'name': nameController.text,
                  'location': locationController.text,
                });
                Navigator.pop(context);
              },
              child: Text('Add Machine'),
            ),
          ],
        ),
      ),
    );
  }
}
