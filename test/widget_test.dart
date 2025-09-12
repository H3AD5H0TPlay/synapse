// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:synapse/main.dart';

void main() {
  testWidgets('App renders the main screen with title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // We need to use our actual app widget, SynapseApp, instead of the old MyApp.
    await tester.pumpWidget(const SynapseApp());

    // ADDED FIX: Wait for all asynchronous operations, like the 3D model loading,
    // to complete before proceeding with the test. This prevents the crash.
    await tester.pumpAndSettle();

    // Verify that our app's title 'Synapse' is present in the AppBar.
    // This is a simple but effective test to ensure the main screen loads correctly.
    expect(find.text('Synapse'), findsOneWidget);
  });
}

