part of 'posts_bloc.dart';

abstract class PostsEvent {}

class GetAllPosts extends PostsEvent {}

class CreatePost extends PostsEvent {
  final String title;
  final String description;

  CreatePost(this.title, this.description);
}

class UpdatePost extends PostsEvent {
  final String id;
  final String title;
  final String description;

  UpdatePost(this.id, this.title, this.description);
}
