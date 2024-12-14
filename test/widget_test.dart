import 'package:flutter/material.dart';
import 'package:flutter_posts_app/data/posts_data_source.dart';
import 'package:flutter_posts_app/data/posts_repository.dart';
import 'package:flutter_posts_app/main.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('Posts list displays correctly', (WidgetTester tester) async {
    // Create a fake repository with some initial posts.
    final repository = PostsRepository(FakePostsDataSource());

    // Build the app with the required repository.
    await tester.pumpWidget(MyApp(repository: repository));

    // Verify that the loading indicator is shown first.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the posts to load.
    await tester.pumpAndSettle();

    // Verify that posts are displayed.
    expect(find.text('Post 1'), findsOneWidget);
    expect(find.text('Description of Post 1'), findsOneWidget);
    expect(find.text('Post 2'), findsOneWidget);
    expect(find.text('Description of Post 2'), findsOneWidget);

    // Verify that the "Add Post" button is displayed.
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Add Post button navigates to create screen', (WidgetTester tester) async {
    // Create a fake repository.
    final repository = PostsRepository(FakePostsDataSource());

    // Build the app with the required repository.
    await tester.pumpWidget(MyApp(repository: repository));

    // Wait for the posts to load.
    await tester.pumpAndSettle();

    // Tap the "Add Post" button.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that we navigated to the PostCreateScreen.
    expect(find.text('Create Post'), findsOneWidget);
  });
}
