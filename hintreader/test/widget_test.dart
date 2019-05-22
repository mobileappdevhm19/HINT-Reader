// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hintreader/main.dart';

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
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(800.0, 600.0));
    await tester.pumpAndSettle();
    expect(find.text("My bookshelf"), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(FlatButton), findsWidgets);
    await tester.tap(find.byType(FlatButton));
    await tester.pumpAndSettle();
    await binding.setSurfaceSize(Size(800.0, 600.0));
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byIcon(Icons.wb_sunny), findsOneWidget);
    expect(find.text("A"), findsOneWidget);
    expect(find.text("a"), findsOneWidget);
  });

  testWidgets('Test orientation portrait', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(600.0, 800.0));
    await tester.pumpAndSettle();
    expect(find.text("My bookshelf"), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(FlatButton), findsWidgets);
    await tester.tap(find.byType(FlatButton));
    await tester.pumpAndSettle();
    await binding.setSurfaceSize(Size(600.0, 800.0));
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byIcon(Icons.wb_sunny), findsOneWidget);
    expect(find.text("A"), findsOneWidget);
    expect(find.text("a"), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(8));
  });

  //test for landscape mode
  testWidgets('Test orientation landscape with no darkomode and normalsize', (WidgetTester tester) async {

    String expectImage = "Image(image: AssetImage(bundle: null, name: \"assets/horizontalNormalNoDarkmode.PNG\")";

    await tester.pumpWidget(MyApp());
    final TestWidgetsFlutterBinding binding =
    TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(600.0, 800.0));
    await tester.pumpAndSettle();
    expect(find.text("My bookshelf"), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(FlatButton), findsWidgets);
    await tester.tap(find.byType(FlatButton));
    await tester.pumpAndSettle();
    await binding.setSurfaceSize(Size(800.0, 600.0));
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byIcon(Icons.wb_sunny), findsOneWidget);
    expect(find.text("A"), findsOneWidget);
    expect(find.text("a"), findsOneWidget);
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 84), expectImage);
  });

  testWidgets('Test orientation landscape with no darkomode and small size', (WidgetTester tester) async {

    String expectImage = "Image(image: AssetImage(bundle: null, name: \"assets/horizontalSmallNoDarkmode.PNG\")";

    await tester.pumpWidget(MyApp());
    final TestWidgetsFlutterBinding binding =
    TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(600.0, 800.0));
    await tester.pumpAndSettle();
    expect(find.text("My bookshelf"), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(FlatButton), findsWidgets);
    await tester.tap(find.byType(FlatButton));
    await tester.pumpAndSettle();
    await binding.setSurfaceSize(Size(800.0, 600.0));
    await tester.pumpAndSettle();
    await tester.tap(find.text("a"));
    await tester.pumpAndSettle();
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 83), expectImage);
  });

  testWidgets('Test orientation landscape with no darkomode and Large size', (WidgetTester tester) async {

    String expectImage = "Image(image: AssetImage(bundle: null, name: \"assets/horizontalLargeNoDarkmode.PNG\")";

    await tester.pumpWidget(MyApp());
    final TestWidgetsFlutterBinding binding =
    TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(600.0, 800.0));
    await tester.pumpAndSettle();
    expect(find.text("My bookshelf"), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(FlatButton), findsWidgets);
    await tester.tap(find.byType(FlatButton));
    await tester.pumpAndSettle();
    await binding.setSurfaceSize(Size(800.0, 600.0));
    await tester.pumpAndSettle();
    await tester.tap(find.text("A"));
    await tester.pumpAndSettle();
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 83), expectImage);
  });

  testWidgets('Test orientation landscape with darkomode and Large size', (WidgetTester tester) async {

    String expectImage = "Image(image: AssetImage(bundle: null, name: \"assets/horizontalLargeDarkmode.PNG\")";

    await tester.pumpWidget(MyApp());
    final TestWidgetsFlutterBinding binding =
    TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(600.0, 800.0));
    await tester.pumpAndSettle();
    expect(find.text("My bookshelf"), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(FlatButton), findsWidgets);
    await tester.tap(find.byType(FlatButton));
    await tester.pumpAndSettle();
    await binding.setSurfaceSize(Size(800.0, 600.0));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.wb_sunny));
    await tester.pumpAndSettle();
    await tester.tap(find.text("A"));
    await tester.pumpAndSettle();
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 81), expectImage);
  });

  testWidgets('Test orientation landscape with darkomode and small size', (WidgetTester tester) async {

    String expectImage = "Image(image: AssetImage(bundle: null, name: \"assets/horizontalSmallDarkmode.PNG\")";

    await tester.pumpWidget(MyApp());
    final TestWidgetsFlutterBinding binding =
    TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(600.0, 800.0));
    await tester.pumpAndSettle();
    expect(find.text("My bookshelf"), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(FlatButton), findsWidgets);
    await tester.tap(find.byType(FlatButton));
    await tester.pumpAndSettle();
    await binding.setSurfaceSize(Size(800.0, 600.0));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.wb_sunny));
    await tester.pumpAndSettle();
    await tester.tap(find.text("a"));
    await tester.pumpAndSettle();
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 81), expectImage);
  });



}
