// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robin_book/domain/models/work_search/work_search_item.dart';

import 'package:robin_book/main.dart';

void main() {
  testWidgets('Searching for a book', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Robin Book'), findsOneWidget);
    expect(find.text('Search by title or author'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'the little prince');
    await tester.pump(const Duration(milliseconds: 700));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
