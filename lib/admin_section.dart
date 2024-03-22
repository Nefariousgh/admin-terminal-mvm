import 'package:flutter/material.dart';

class AdminSection extends StatelessWidget {
  const AdminSection({super.key});

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
  const AddVendingMachineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vending Machine'),
      ),
      body: const Center(
        // Add form fields to enter vending machine details
        child: Text('Add Vending Machine Form'),
      ),
    );
  }
}
