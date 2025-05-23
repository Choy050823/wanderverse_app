import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final String creatorId;
  final String destination;
  final int initialLikes;
  final String imageUrl;
  final String profilePicUrl;
  final String caption;

  const PostCard({
    super.key,
    required this.creatorId,
    required this.destination,
    required this.initialLikes,
    required this.imageUrl,
    required this.profilePicUrl,
    required this.caption,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool liked = false;
  late int likes;

  @override
  void initState() {
    super.initState();
    likes = widget.initialLikes;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(widget.profilePicUrl),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.creatorId,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          widget.destination,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Image.network(
                widget.imageUrl,
                width: MediaQuery.of(context).size.width / 100 * 80,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 100 * 80,
                    height: MediaQuery.of(context).size.width / 100 * 80,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 100 * 80,
                    height: MediaQuery.of(context).size.width / 100 * 80,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, color: theme.colorScheme.error),
                          Text(
                            'Error Loading Image!',
                            style: TextStyle(color: theme.colorScheme.error),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            setState(() {
                              liked = !liked;
                              likes = liked ? likes + 1 : likes - 1;
                            });
                          },
                          icon: liked
                              ? Icon(
                                  Icons.favorite,
                                  color: theme.colorScheme.error,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: theme.colorScheme.onSurface,
                                ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '$likes',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      onPressed: () {},
                      icon: Icon(
                        Icons.comment_outlined,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    IconButton(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      onPressed: () {},
                      icon: Icon(
                        Icons.bookmark_outline,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Text(
                  widget.caption,
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
