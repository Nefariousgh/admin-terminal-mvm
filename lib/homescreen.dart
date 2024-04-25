import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_medicine_screen.dart';
import 'add_vending_machine_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vending Machines', textAlign: TextAlign.center),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('vending_machines').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length + 1,
                  itemBuilder: (context, index) {
                    if (index == snapshot.data!.docs.length) {
                      return ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddVendingMachineScreen()),
                          );
                        },
                        child: Text('Add Vending Machine'),
                      );
                    }
                    var machine = snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MachineDetailsScreen(machine)),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(machine['name']),
                          subtitle: Text(machine['location']),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MachineDetailsScreen extends StatelessWidget {
  final DocumentSnapshot machine;

  MachineDetailsScreen(this.machine);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(machine['name'], textAlign: TextAlign.center),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Machine Name: ${machine['name']}'),
            subtitle: Text('Location: ${machine['location']}'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddMedicineScreen(machineId: machine.id), // Pass machine.id as machineId
                ),
              );
            },
            child: Text('Add Medicines'),
          ),
          // Display medicines here based on the machine ID
        ],
      ),
    );
  }
}
