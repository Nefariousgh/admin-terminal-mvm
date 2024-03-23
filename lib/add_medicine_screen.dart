import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMedicineScreen extends StatefulWidget {
  final String machineId; // Change the type to String

  AddMedicineScreen({required this.machineId});

  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}
  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();


class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Medicines'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Medicine Name'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                _addMedicine();
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
                    .doc(widget.machineId)
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
                        subtitle: Text('Price: \$${medicine['price']} | Quantity: ${medicine['quantity']}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addMedicine() async {
    String name = _nameController.text;
    double price = double.parse(_priceController.text);
    int quantity = int.parse(_quantityController.text);

    try {
      await FirebaseFirestore.instance
          .collection('vending_machines')
          .doc(widget.machineId)
          .collection('medicines')
          .add({
        'name': name,
        'price': price,
        'quantity': quantity,
      });
      _nameController.clear();
      _priceController.clear();
      _quantityController.clear();
    } catch (e) {
      print('Error adding medicine: $e');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }
}
