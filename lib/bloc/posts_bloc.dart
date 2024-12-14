import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../data/post.dart';
import '../data/posts_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';


class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository repository;

  PostsBloc(this.repository) : super(PostsState()) {
    on<GetAllPosts>(_onGetAllPosts);
    on<CreatePost>(_onCreatePost);
    on<UpdatePost>(_onUpdatePost);
  }

  Future<void> _onGetAllPosts(GetAllPosts event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.loading));
    try {
      final posts = await repository.fetchPosts();
      emit(state.copyWith(status: PostsStatus.success, posts: posts));
    } catch (e) {
      emit(state.copyWith(status: PostsStatus.error, exception: e.toString()));
    }
  }

  Future<void> _onCreatePost(CreatePost event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.loading));
    try {
      final newPost = Post(id: DateTime.now().toString(), title: event.title, description: event.description);
      await repository.addPost(newPost);
      final updatedPosts = List<Post>.from(state.posts)..add(newPost);
      emit(state.copyWith(status: PostsStatus.success, posts: updatedPosts));
    } catch (e) {
      emit(state.copyWith(status: PostsStatus.error, exception: e.toString()));
    }
  }

  Future<void> _onUpdatePost(UpdatePost event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.loading));
    try {
      final updatedPost = Post(id: event.id, title: event.title, description: event.description);
      await repository.editPost(updatedPost);
      final updatedPosts = state.posts.map((post) => post.id == updatedPost.id ? updatedPost : post).toList();
      emit(state.copyWith(status: PostsStatus.success, posts: updatedPosts));
    } catch (e) {
      emit(state.copyWith(status: PostsStatus.error, exception: e.toString()));
    }
  }
}
