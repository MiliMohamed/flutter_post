import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/posts_bloc.dart';
import 'data/posts_repository.dart';
import 'data/posts_data_source.dart';
import 'screens/posts_list_screen.dart';

void main() {
  final repository = PostsRepository(FakePostsDataSource());
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
        create: (_) => PostsBloc(repository)..add(GetAllPosts()),
        child: PostsListScreen(),
      ),
    );
  }
}
