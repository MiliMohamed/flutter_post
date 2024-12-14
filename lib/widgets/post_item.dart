import 'package:flutter/material.dart';

import '../data/post.dart';

class PostItem extends StatelessWidget {
  final Post post;
  final VoidCallback onTap;

  const PostItem({Key? key, required this.post, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(post.title),
        subtitle: Text(post.description),
        onTap: onTap,
      ),
    );
  }
}
