import 'package:cloud_firestore/cloud_firestore.dart';
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
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Update Quantity'),
                                    content: TextField(
                                      controller: TextEditingController(text: medicine['quantity'].toString()),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(labelText: 'New Quantity'),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Update quantity logic
                                          Navigator.pop(context);
                                        },
                                        child: Text('Update'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Implement delete medicine functionality
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Confirm Delete'),
                                    content: Text('Are you sure you want to delete this medicine?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Delete logic
                                          Navigator.pop(context);
                                        },
                                        child: Text('Delete'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel'),
                                      ),
                                    ],
                                  );
                                },
                              );
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
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddMedicineScreen(machineId: machine.id)),
              );
            },
            child: Text('Add Medicine'),
          ),
        ],
      ),
    );
  }
}
