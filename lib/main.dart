import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/posts_dart_cubit.dart';
import 'data/posts_data_source.dart';
import 'data/posts_repository.dart';
import 'screens/posts_list_screen.dart';

void main() {
  final fakeDataSource = FakePostsDataSource();
  final repository = PostsRepository(fakeDataSource);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final PostsRepository repository;

  const MyApp({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Posts App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (_) => PostsCubit(repository),
        child: PostsListScreen(),
      ),
    );
  }
}
