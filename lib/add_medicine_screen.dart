import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMedicineScreen extends StatefulWidget {
  final String machineId;

  AddMedicineScreen({required this.machineId});

  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> with WidgetsBindingObserver {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  bool isEditing = false;
  late String editingMedicineId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Clear cache when app is paused (backgrounded or closed)
      clearCache();
    }
  }

  Future<void> clearCache() async {
    try {
      await FirebaseFirestore.instance.clearPersistence();
    } catch (e) {
      print('Error clearing cache: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Medicine' : 'Add Medicines'),
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
                if (isEditing) {
                  _editMedicine(editingMedicineId);
                } else {
                  _addMedicine();
                }
              },
              child: Text(isEditing ? 'Update Medicine' : 'Add Medicine'),
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
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                setState(() {
                                  isEditing = true;
                                  editingMedicineId = medicine.id;
                                  _nameController.text = medicine['name'];
                                  _priceController.text = medicine['price'].toString();
                                  _quantityController.text = medicine['quantity'].toString();
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteMedicine(medicine.id);
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

  void _editMedicine(String medicineId) async {
    String name = _nameController.text;
    double price = double.parse(_priceController.text);
    int quantity = int.parse(_quantityController.text);

    try {
      await FirebaseFirestore.instance
          .collection('vending_machines')
          .doc(widget.machineId)
          .collection('medicines')
          .doc(medicineId)
          .update({
        'name': name,
        'price': price,
        'quantity': quantity,
      });
      setState(() {
        isEditing = false;
        editingMedicineId = '';
        _nameController.clear();
        _priceController.clear();
        _quantityController.clear();
      });
    } catch (e) {
      print('Error editing medicine: $e');
    }
  }

  void _deleteMedicine(String medicineId) async {
    try {
      await FirebaseFirestore.instance
          .collection('vending_machines')
          .doc(widget.machineId)
          .collection('medicines')
          .doc(medicineId)
          .delete();
    } catch (e) {
      print('Error deleting medicine: $e');
    }
  }

}
