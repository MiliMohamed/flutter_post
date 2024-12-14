import 'dart:async';
import 'post.dart';

class FakePostsDataSource {
  final List<Post> _fakePosts = [
    Post(id: '1', title: 'Post 1', description: 'Description of Post 1'),
    Post(id: '2', title: 'Post 2', description: 'Description of Post 2'),
    Post(id: '3', title: 'Post 3', description: 'Description of Post 3'),
  ];

  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakePosts;
  }

  Future<Post> createPost(Post post) async {
    await Future.delayed(const Duration(seconds: 1));
    _fakePosts.add(post);
    return post;
  }

  Future<Post> updatePost(Post updatedPost) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _fakePosts.indexWhere((post) => post.id == updatedPost.id);
    if (index != -1) {
      _fakePosts[index] = updatedPost;
    }
    return updatedPost;
  }

}



