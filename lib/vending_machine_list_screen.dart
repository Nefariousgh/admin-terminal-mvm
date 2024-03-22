import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_medicine_screen.dart';
import 'add_vending_machine_screen.dart';

class VendingMachinesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vending Machines'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('vending_machines').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var machine = snapshot.data!.docs[index];
              return ListTile(
                title: Text(machine['name']),
                subtitle: Text(machine['location']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddMedicineScreen(machine: machine)),
                  );

                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddVendingMachineScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
