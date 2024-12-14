import 'post.dart';
import 'posts_data_source.dart';

class PostsRepository {
  final PostsDataSource dataSource;

  PostsRepository(this.dataSource);

  Future<List<Post>> fetchPosts() => dataSource.getAllPosts();
  Future<Post> addPost(Post post) => dataSource.createPost(post);
  Future<Post> editPost(Post post) => dataSource.updatePost(post);
}
