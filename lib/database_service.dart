import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference vendingMachinesCollection =
  FirebaseFirestore.instance.collection('vending_machines');

  Future<void> addVendingMachine(String name, String location) async {
    try {
      // Add a document to the "vending_machines" collection
      await vendingMachinesCollection.add({
        'name': name,
        'location': location,
      });
    } catch (e) {
      print('Error adding vending machine: $e');
    }
  }

  Future<void> addMedicine(String machineId, String name, double price, int quantity) async {
    try {
      // Get the subcollection reference for the specified vending machine
      final machineRef = vendingMachinesCollection.doc(machineId).collection('medicines');

      // Add a document to the "medicines" subcollection
      await machineRef.add({
        'name': name,
        'price': price,
        'quantity': quantity,
      });
    } catch (e) {
      print('Error adding medicine: $e');
    }
  }
}