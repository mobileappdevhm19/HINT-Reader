// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hintreader/main.dart';
import 'package:hintreader/views/BookView.dart';

void main() {
  testWidgets('Bookshelf display test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text("My bookshelf"), findsOneWidget);
    expect(find.byType(FlatButton), findsOneWidget);
  });


  testWidgets('Change to BookvIew test', (WidgetTester tester) async {


    await tester.pumpWidget(MyApp());
    expect(find.text("My bookshelf"), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(FlatButton), findsWidgets);
    await tester.tap(find.byType(FlatButton));
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byIcon(Icons.wb_sunny), findsOneWidget);
    expect(find.text("A"), findsOneWidget);
    expect(find.text("a"), findsOneWidget);
  });

  testWidgets('Test orientation landscape', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(800.0, 600.0));
    await tester.pumpAndSettle();
    expect(find.text("My bookshelf"), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(FlatButton), findsWidgets);
    await tester.tap(find.byType(FlatButton));
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byIcon(Icons.wb_sunny), findsOneWidget);
    expect(find.text("A"), findsOneWidget);
    expect(find.text("a"), findsOneWidget);
  });

  testWidgets('Test orientation portrait', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(600.0, 800.0));
    await tester.pumpAndSettle();
    expect(find.text("My bookshelf"), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(FlatButton), findsWidgets);
    await tester.tap(find.byType(FlatButton));
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byIcon(Icons.wb_sunny), findsOneWidget);
    expect(find.text("A"), findsOneWidget);
    expect(find.text("a"), findsOneWidget);
  });
  
  
}
