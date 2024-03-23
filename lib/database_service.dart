import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference vendingMachinesCollection =
  FirebaseFirestore.instance.collection('vending_machines');

  Future<void> addVendingMachine(String name, String location) async {
    try {
      // Create a new document with the vending machine name as its ID
      DocumentReference machineRef =
      vendingMachinesCollection.doc(name);

      // Set the data for the vending machine
      await machineRef.set({
        'name': name,
        'location': location,
      });

      print('Vending machine added successfully');
    } catch (e) {
      print('Error adding vending machine: $e');
    }
  }

  Future<void> addMedicine(
      String machineId, String name, double price, int quantity) async {
    try {
      final machineRef = vendingMachinesCollection.doc(machineId).collection('medicines');
      await machineRef.add({
        'name': name,
        'price': price,
        'quantity': quantity,
      });

      print('Medicine added successfully');
    } catch (e) {
      print('Error adding medicine: $e');
    }
  }
}
