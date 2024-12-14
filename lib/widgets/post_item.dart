import 'package:flutter/material.dart';

import '../data/post.dart';
import '../screens/post_detail_screen.dart';

class PostItem extends StatelessWidget {
  final Post post;

  PostItem({required this.post});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title),
      subtitle: Text(post.description),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PostDetailScreen(post: post),
          ),
        );
      },
    );
  }
}
