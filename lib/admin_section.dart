import 'package:flutter/material.dart';

class AdminSection extends StatelessWidget {
  const AdminSection({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Section'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the screen to add vending machines
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddVendingMachineScreen()),
            );
          },
          child: const Text('Add Vending Machines'),
        ),
      ),
    );
  }
}

class AddVendingMachineScreen extends StatelessWidget {
  const AddVendingMachineScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vending Machine'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Machine Name'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Location'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add logic to save vending machine details
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
