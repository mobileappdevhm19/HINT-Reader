// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hintreader/main.dart';
import 'package:hintreader/progbar/MyLinearProgressIndicator.dart';

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


  testWidgets('Test orientation of BookView landscape', (WidgetTester tester) async {
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

  testWidgets('Test orientation of BookView portrait', (WidgetTester tester) async {
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
  });



  testWidgets('Test orientation landscape with no darkomode and normalsize', (WidgetTester tester) async {

    String expectImage = "Image(image: AssetImage(bundle: null, name: \"assets/horizontalNormalNoDarkmode.PNG\")";

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
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 84), expectImage);
  });

  testWidgets('Test orientation landscape with no darkomode and small size', (WidgetTester tester) async {

    String expectImage = "Image(image: AssetImage(bundle: null, name: \"assets/horizontalSmallNoDarkmode.PNG\")";

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
    await tester.tap(find.text("a"));
    await tester.pumpAndSettle();
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 83), expectImage);
  });

  testWidgets('Test orientation landscape with no darkomode and Large size', (WidgetTester tester) async {

    String expectImage = "Image(image: AssetImage(bundle: null, name: \"assets/horizontalLargeNoDarkmode.PNG\")";

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
    await tester.tap(find.text("A"));
    await tester.pumpAndSettle();
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 83), expectImage);
  });

  testWidgets('Test orientation landscape with darkomode and normal size', (WidgetTester tester) async {

    String expectImage = "Image(image: AssetImage(bundle: null, name: \"assets/horizontalNormalDarkmode.PNG\")";

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
    await tester.tap(find.byIcon(Icons.wb_sunny));
    await tester.pumpAndSettle();
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 82), expectImage);
  });

  testWidgets('Test orientation landscape with darkomode and Large size', (WidgetTester tester) async {

    String expectImage = "Image(image: AssetImage(bundle: null, name: \"assets/horizontalLargeDarkmode.PNG\")";

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
    await binding.setSurfaceSize(Size(800.0, 600.0));
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





  testWidgets('Test orientation portrait with no darkomode and normalsize', (WidgetTester tester) async {

    String expectImage = "Image(image: AssetImage(bundle: null, name: \"assets/verticalNormalNoDarkmode.PNG\")";

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
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 82), expectImage);
  });

  testWidgets('Test orientation portrait with no darkomode and small size', (WidgetTester tester) async {

    String expectImage = "Image(image: AssetImage(bundle: null, name: \"assets/verticalSmallNoDarkmode.PNG\")";

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
    await tester.tap(find.text("a"));
    await tester.pumpAndSettle();
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 81), expectImage);
  });

  testWidgets('Test orientation portrait with no darkomode and Large size', (WidgetTester tester) async {

    String expectImage = "Image(image: AssetImage(bundle: null, name: \"assets/verticalLargeNoDarkmode.PNG\")";

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
    await tester.tap(find.text("A"));
    await tester.pumpAndSettle();
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 81), expectImage);
  });

  testWidgets('Test orientation portrait with darkomode and normal size', (WidgetTester tester) async {

    String expectImage = "Image(image: AssetImage(bundle: null, name: \"assets/verticalNormalDarkmode.PNG\")";

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
    await tester.tap(find.byIcon(Icons.wb_sunny));
    await tester.pumpAndSettle();
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 80), expectImage);
  });

  testWidgets('Test orientation portrait with darkomode and Large size', (WidgetTester tester) async {

    String expectImage = "Image(image: AssetImage(bundle: null, name: \"assets/verticalLargeDarkmode.PNG\")";

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
    await tester.tap(find.byIcon(Icons.wb_sunny));
    await tester.pumpAndSettle();
    await tester.tap(find.text("A"));
    await tester.pumpAndSettle();
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 79), expectImage);
  });

  testWidgets('Test orientation portrait with darkomode and small size', (WidgetTester tester) async {

    String expectImage = "Image(image: AssetImage(bundle: null, name: \"assets/verticalSmallDarkmode.PNG\")";

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
    await tester.tap(find.byIcon(Icons.wb_sunny));
    await tester.pumpAndSettle();
    await tester.tap(find.text("a"));
    await tester.pumpAndSettle();
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 79), expectImage);
  });


  testWidgets('Darkmode back to no darkmode', (WidgetTester tester) async {

    String expectImageD = "Image(image: AssetImage(bundle: null, name: \"assets/verticalNormalDarkmode.PNG\")";
    String expectImageND = "Image(image: AssetImage(bundle: null, name: \"assets/verticalNormalNoDarkmode.PNG\")";

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
    await tester.tap(find.byIcon(Icons.wb_sunny));
    await tester.pumpAndSettle();
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 80), expectImageD);
    await tester.tap(find.byIcon(Icons.wb_sunny));
    await tester.pumpAndSettle();
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 82), expectImageND);
  });

  testWidgets('small size back to normal', (WidgetTester tester) async {

    String expectImageS = "Image(image: AssetImage(bundle: null, name: \"assets/verticalSmallNoDarkmode.PNG\")";
    String expectImageN = "Image(image: AssetImage(bundle: null, name: \"assets/verticalNormalNoDarkmode.PNG\")";

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
    await tester.tap(find.text("a"));
    await tester.pumpAndSettle();
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 81), expectImageS);
    await tester.tap(find.text("a"));
    await tester.pumpAndSettle();
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 82), expectImageN);
  });

  testWidgets('Large size back to normal', (WidgetTester tester) async {

    String expectImageL = "Image(image: AssetImage(bundle: null, name: \"assets/horizontalLargeNoDarkmode.PNG\")";
    String expectImageN = "Image(image: AssetImage(bundle: null, name: \"assets/horizontalNormalNoDarkmode.PNG\")";

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
    await tester.tap(find.text("A"));
    await tester.pumpAndSettle();
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 83), expectImageL);
    await tester.tap(find.text("A"));
    await tester.pumpAndSettle();
    expect(tester.firstElement(find.byType(Image)).toString().substring(0, 84), expectImageN);
  });

  testWidgets('Progressbar', (WidgetTester tester) async {

    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FlatButton));
    await tester.pumpAndSettle();
    expect(find.byType(MyLinearProgressIndicator), findsOneWidget);
  });

  testWidgets('Progressbar value', (WidgetTester tester) async {

    String expectValue = "MyLinearProgressIndicator(33.5%";
    final bar = MyLinearProgressIndicator();
    final value = bar.value;
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FlatButton));
    await tester.pumpAndSettle();
    expect(tester.firstElement(find.byType(MyLinearProgressIndicator)).toString().substring(0, 31), expectValue);
  });
}
