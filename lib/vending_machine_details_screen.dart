import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_medicine_screen.dart';

class VendingMachineDetailsScreen extends StatelessWidget {
  final DocumentSnapshot machine;

  VendingMachineDetailsScreen(this.machine);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(machine['name']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Location: ${machine['location']}'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddMedicineScreen(machineId: machine.id), // Assuming machine.id is the machine ID
                  ),
                );


              },
              child: Text('Add Medicines'),
            ),
          ],
        ),
      ),
    );
  }
}
