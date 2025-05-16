import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final String creatorId;
  final String destination;
  final int initialLikes;
  final String imageUrl;
  final String profilePicUrl;
  final String caption;
  final double height;

  const PostCard(
      {super.key,
      required this.creatorId,
      required this.destination,
      required this.initialLikes,
      required this.imageUrl,
      required this.profilePicUrl,
      required this.caption,
      required this.height});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool liked = false;
  late int likes;

  @override
  void initState() {
    super.initState();
    likes = widget.initialLikes; // Initialize with the passed value
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 10,
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
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(widget.destination)
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
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 100 * 80,
                    height: MediaQuery.of(context).size.width / 100 * 80,
                    child: const Center(
                        child: Column(
                      children: [
                        Icon(Icons.error),
                        Text('Error Loading Image!')
                      ],
                    )),
                  );
                },
              ),
              const SizedBox(height: 5),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      // Favorite icon and likes with minimal gap
                      Row(
                        children: [
                          IconButton(
                            padding: const EdgeInsets.all(0), // Remove padding
                            constraints:
                                const BoxConstraints(), // Remove default constraints
                            onPressed: () {
                              setState(() {
                                liked = !liked;
                                likes = liked ? likes + 1 : likes - 1;
                              });
                            },
                            icon: liked
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(Icons.favorite_border),
                          ),
                          const SizedBox(
                              width: 2), // Minimal gap between icon and text
                          Text(
                            '$likes',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10), // Normal gap before comments
                      IconButton(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        onPressed: () {},
                        icon: const Icon(Icons.comment_outlined),
                      ),
                      IconButton(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        onPressed: () {},
                        icon: const Icon(Icons.bookmark_outline),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Text(
                  widget.caption,
                  style: const TextStyle(fontSize: 14.0),
                  textAlign: TextAlign.left, // Explicitly align to the left
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
