import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:demo_app/add_medicines.dart';
import 'package:demo_app/add_vending_machine.dart';


void main() {
  testWidgets('Add Vending Machine Screen Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: AddVendingMachine()));

    // Verify that the "Machine Name" and "Location" text fields are present.
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Machine Name'), findsOneWidget);
    expect(find.text('Location'), findsOneWidget);

    // Enter text in the text fields.
    await tester.enterText(find.byType(TextField).first, 'Test Machine');
    await tester.enterText(find.byType(TextField).last, 'Test Location');

    // Tap the save button.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Add your logic to test the functionality after saving (e.g., navigation, data storage).
  });

  testWidgets('Add Medicines Screen Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: AddMedicines()));

    // Verify that the "Medicine Name", "Price", and "Quantity" text fields are present.
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.text('Medicine Name'), findsOneWidget);
    expect(find.text('Price'), findsOneWidget);
    expect(find.text('Quantity'), findsOneWidget);

    // Enter text in the text fields.
    await tester.enterText(find.byType(TextField).at(0), 'Test Medicine');
    await tester.enterText(find.byType(TextField).at(1), '10.0'); // Assuming price is a double
    await tester.enterText(find.byType(TextField).at(2), '100'); // Assuming quantity is an integer

    // Tap the save button.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Add your logic to test the functionality after saving (e.g., navigation, data storage).
  });
}
