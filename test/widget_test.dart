import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_posts/main.dart';
import 'package:flutter_posts/data/posts_repository.dart';
import 'package:flutter_posts/data/posts_data_source.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Create a fake repository for the test.
    final repository = PostsRepository(FakePostsDataSource());

    // Build the app and provide the required repository.
    await tester.pumpWidget(MyApp(repository: repository));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
