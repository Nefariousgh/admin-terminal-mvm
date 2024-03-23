import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/database_service.dart';

 // Replace 'your_app_name' with your actual app name

class VendingMachineDisplay extends StatelessWidget {
  final DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vending Machines'),
      ),
      body: StreamBuilder(
        stream: _db.vendingMachinesCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<VendingMachine> machines = snapshot.data!.docs.map((doc) {
            return VendingMachine(
              id: doc.id,
              name: doc['name'],
              location: doc['location'],
            );
          }).toList();

          return ListView.builder(
            itemCount: machines.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(machines[index].name),
                subtitle: Text(machines[index].location),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddMedicineScreen(machines[index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to screen to add vending machine
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class VendingMachine {
  final String id;
  final String name;
  final String location;

  VendingMachine({
    required this.id,
    required this.name,
    required this.location,
  });
}

class AddMedicineScreen extends StatelessWidget {
  final VendingMachine vendingMachine;

  AddMedicineScreen(this.vendingMachine);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Medicines to ${vendingMachine.name}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Add Medicines Here'),
            // Add form fields and logic to add medicines
          ],
        ),
      ),
    );
  }
}
