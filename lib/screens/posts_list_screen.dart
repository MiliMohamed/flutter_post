import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_app/screens/post_detail_screen.dart';

import '../bloc/posts_bloc.dart';
import '../widgets/post_item.dart';
import 'post_create_screen.dart';

class PostsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state.status == PostsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == PostsStatus.success) {
            if (state.posts.isEmpty) {
              return const Center(
                child: Text('No posts available.'),
              );
            }
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return PostItem(
                  post: post,
                  onTap: () {
                    // Naviguer vers l'écran de détail
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PostDetailScreen(post: post),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state.status == PostsStatus.error) {
            return Center(
              child: Text(
                state.error ?? 'An error occurred.',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers l'écran de création
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PostCreateScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
