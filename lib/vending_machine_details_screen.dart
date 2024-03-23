import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_medicine_screen.dart';

class MachineDetailsScreen extends StatelessWidget {
  final DocumentSnapshot machine;

  MachineDetailsScreen(this.machine);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(machine['name']),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddMedicineScreen(machineId: machine.id)),
              );
            },
            child: Text('Add Medicine'),
          ),
          SizedBox(height: 20),
          Text(
            'Added Medicines:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('vending_machines')
                  .doc(machine.id)
                  .collection('medicines')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var medicine = snapshot.data!.docs[index];
                    return ListTile(
                      title: Text(medicine['name']),
                      subtitle: Text('Price: ${medicine['price']}, Quantity: ${medicine['quantity']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Implement update quantity functionality
                              // You can use a dialog or another screen for updating the quantity
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Implement delete medicine functionality
                              // You can show a confirmation dialog before deleting
                            },
                          ),
                        ],
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
