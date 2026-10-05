import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nematov_portfolio/main.dart';
import 'package:nematov_portfolio/projects.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    for (final family in ['Inter', 'PlusJakartaSans', 'JetBrainsMono']) {
      final loader = FontLoader(family)
        ..addFont(rootBundle.load('assets/fonts/$family.ttf'));
      await loader.load();
    }
  });
  test('Every project screenshot asset loads', () async {
    for (final project in projects) {
      for (final imagePath in project.images) {
        final imageData = await rootBundle.load(imagePath);
        expect(imageData.lengthInBytes, greaterThan(0), reason: imagePath);
      }
    }
  });
  test('Every project has valid App Store and Google Play links', () {
    for (final project in projects) {
      final appStoreUri = Uri.parse(project.appStoreUrl);
      final googlePlayUri = Uri.parse(project.googlePlayUrl);
      expect(appStoreUri.isScheme('https'), isTrue, reason: project.name);
      expect(appStoreUri.host, 'apps.apple.com', reason: project.name);
      expect(googlePlayUri.isScheme('https'), isTrue, reason: project.name);
      expect(googlePlayUri.host, 'play.google.com', reason: project.name);
    }
  });
  for (final width in [360.0, 768.0, 1280.0]) {
    testWidgets('Portfolio has no layout overflow at $width px', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text('Have a Flutter project in mind?'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }
  testWidgets('Project preview opens and closes', (tester) async {
    tester.view.physicalSize = const Size(1280, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: SingleChildScrollView(
            child: ProjectCard(
              project: projects.firstWhere(
                (project) => project.name == 'Paylov',
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('CARD TRANSFERS'));
    await tester.tap(find.text('CARD TRANSFERS'));
    await tester.pumpAndSettle();
    expect(find.byType(Dialog), findsOneWidget);
    await tester.tap(find.byTooltip('Close preview'));
    await tester.pumpAndSettle();
    expect(find.byType(Dialog), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
