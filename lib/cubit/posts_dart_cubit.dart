import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/post.dart';
import '../data/posts_repository.dart';

abstract class PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final List<Post> posts;

  PostsLoaded(this.posts);
}

class PostsError extends PostsState {
  final String message;

  PostsError(this.message);
}

class PostsCubit extends Cubit<PostsState> {
  final PostsRepository repository;

  PostsCubit(this.repository) : super(PostsLoading());

  void loadPosts() async {
    try {
      final posts = await repository.fetchPosts();
      emit(PostsLoaded(posts));
    } catch (_) {
      emit(PostsError('Failed to load posts.'));
    }
  }

  void addPost(Post post) async {
    try {
      await repository.addPost(post);
      loadPosts(); // Refresh the list
    } catch (_) {
      emit(PostsError('Failed to add post.'));
    }
  }

  void updatePost(Post post) async {
    try {
      await repository.editPost(post);
      loadPosts(); // Refresh the list
    } catch (_) {
      emit(PostsError('Failed to update post.'));
    }
  }
}
