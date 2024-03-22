import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMedicineScreen extends StatelessWidget {
  final DocumentSnapshot machine; // Define a field to hold the machine data

  AddMedicineScreen({required this.machine}); // Constructor that accepts machine as a required parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Medicine'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Add Medicines for ${machine['name']}'), // Display machine name
            SizedBox(height: 20.0),
            // Add form fields to add medicines (name, price, quantity) here
          ],
        ),
      ),
    );
  }
}
