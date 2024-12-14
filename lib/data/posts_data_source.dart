import 'dart:async';

import 'post.dart';

abstract class PostsDataSource {
  Future<List<Post>> getAllPosts();
  Future<Post> createPost(Post postToAdd);
  Future<Post> updatePost(Post updatedPost);
}

class FakePostsDataSource implements PostsDataSource {
  final List<Post> _fakePosts = [
    Post(id: '1', title: 'Post 1', description: 'Description of Post 1'),
    Post(id: '2', title: 'Post 2', description: 'Description of Post 2'),
  ];

  @override
  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1)); // Simule un délai
    return _fakePosts;
  }

  @override
  Future<Post> createPost(Post postToAdd) async {
    await Future.delayed(const Duration(seconds: 1));
    _fakePosts.add(postToAdd);
    return postToAdd;
  }

  @override
  Future<Post> updatePost(Post updatedPost) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _fakePosts.indexWhere((post) => post.id == updatedPost.id);
    if (index != -1) {
      _fakePosts[index] = updatedPost;
    }
    return updatedPost;
  }
}
