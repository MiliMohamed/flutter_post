import 'package:flutter/material.dart';
import '../data/post.dart';

class PostItem extends StatelessWidget {
  final Post post;
  final VoidCallback onEdit;
  final VoidCallback onTap;

  const PostItem({
    Key? key,
    required this.post,
    required this.onEdit,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        title: Text(
          post.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          post.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: onEdit,
        ),
        onTap: onTap,
      ),
    );
  }
}
