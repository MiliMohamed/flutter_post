import 'package:flutter/material.dart';
import 'package:flutter_posts_app/data/posts_data_source.dart';
import 'package:flutter_posts_app/data/posts_repository.dart';
import 'package:flutter_posts_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Posts list displays correctly', (WidgetTester tester) async {
    final repository = PostsRepository(FakePostsDataSource());

    await tester.pumpWidget(MyApp(repository: repository));

    // Vérifie que le chargement s'affiche
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Attend que les données soient chargées
    await tester.pumpAndSettle();

    // Vérifie que les posts sont affichés
    expect(find.text('Post 1'), findsOneWidget);
    expect(find.text('Description of Post 1'), findsOneWidget);
    expect(find.text('Post 2'), findsOneWidget);
    expect(find.text('Description of Post 2'), findsOneWidget);

    // Vérifie que le bouton "Add Post" est affiché
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Add Post button navigates to create screen', (WidgetTester tester) async {
    final repository = PostsRepository(FakePostsDataSource());

    await tester.pumpWidget(MyApp(repository: repository));

    await tester.pumpAndSettle();

    // Vérifie la navigation vers l'écran de création
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('Create Post'), findsOneWidget);
  });
}
