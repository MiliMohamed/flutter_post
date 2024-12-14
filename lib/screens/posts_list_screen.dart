import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/posts_bloc.dart';
import '../widgets/post_item.dart';
import 'post_detail_screen.dart';
import 'post_create_screen.dart';

class PostsListScreen extends StatelessWidget {
  const PostsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts List'),
        centerTitle: true,
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state.status == PostsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == PostsStatus.error) {
            return Center(child: Text('Error: ${state.exception ?? 'Unknown error'}'));
          } else if (state.posts.isEmpty) {
            return const Center(child: Text('No posts available.'));
          }

          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return PostItem(
                post: post,
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<PostsBloc>(),
                        child: PostDetailScreen(post: post),
                      ),
                    ),
                  );
                },
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected: ${post.title}')),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const PostCreateScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
