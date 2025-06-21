// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/providers/models.dart';
import 'package:wanderverse_app/providers/post-sharing/likeService.dart';
import 'package:wanderverse_app/utils/constants.dart';
import 'package:wanderverse_app/utils/widgets/ImagePreview.dart';
import 'package:wanderverse_app/utils/widgets/PostCategoryChip.dart';

class DiscussionCard extends ConsumerStatefulWidget {
  final Post post;
  final int index;
  final Widget screen;

  const DiscussionCard(
      {required this.post,
      required this.index,
      required this.screen,
      super.key});

  @override
  ConsumerState<DiscussionCard> createState() => _DiscussionCardState();
}

class _DiscussionCardState extends ConsumerState<DiscussionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    if (mounted) {
      _animationController.forward();
    }

    // Initialize the like service with the post's data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref
            .read(likeServiceProvider(int.parse(widget.post.id)).notifier)
            .initWithPostData(widget.post.likesCount);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate and clamp the interval values to valid ranges
    final beginInterval = (0.1 * widget.index).clamp(0.0, 0.9);
    final endInterval = (beginInterval + 0.6).clamp(beginInterval + 0.1, 1.0);

    final staggeredAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Interval(beginInterval, endInterval, curve: Curves.easeInOut),
    );

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Watch the provider without any additional parameters
    final likeDataAsync =
        ref.watch(likeServiceProvider(int.parse(widget.post.id)));

    return FadeTransition(
        opacity: staggeredAnimation,
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
              .animate(staggeredAnimation),
          child: Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: Theme.of(context).cardTheme.elevation ?? 0,
            shape: Theme.of(context).cardTheme.shape ??
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: colorScheme.outline.withOpacity(0.1)),
                ),
            child: ClipRRect(
              borderRadius: Theme.of(context).cardTheme.shape != null
                  ? (Theme.of(context).cardTheme.shape
                          as RoundedRectangleBorder)
                      .borderRadius as BorderRadius
                  : BorderRadius.circular(16),
              child: InkWell(
                // navigate to specific post discussion screen
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => widget.screen,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User info & post type
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colorScheme.outline.withOpacity(0.2),
                                width: 1,
                              ),
                              image: const DecorationImage(
                                image: NetworkImage(
                                  "https://plus.unsplash.com/premium_photo-1665203415837-a3b389a6b33e?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dHJhdmVsbGVyfGVufDB8fDB8fHww",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.post.creator.username,
                                style: textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                getTimeAgo(widget.post.updatedAt),
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          PostCategoryChip(postType: widget.post.postType)
                        ],
                      ),
                    ),

                    // Post Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        widget.post.title,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    // Post Content
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Text(
                        widget.post.content,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium?.copyWith(
                          height: 1.4,
                        ),
                      ),
                    ),

                    // Post image if available
                    if (widget.post.imageUrls.isNotEmpty)
                      ImagePreview(selectedFiles: widget.post.imageUrls),

                    // Engagement Bar
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? colorScheme.surfaceVariant.withOpacity(0.5)
                            : colorScheme.surfaceVariant,
                        border: Border(
                          top: BorderSide(
                            color: colorScheme.outline.withOpacity(0.2),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Like button and count
                          Row(
                            children: [
                              likeDataAsync.when(
                                data: (likeData) => IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    // Just call the toggle function
                                    ref
                                        .read(likeServiceProvider(
                                                int.parse(widget.post.id))
                                            .notifier)
                                        .toggleLike(widget.post.id);
                                  },
                                  icon: Icon(
                                    likeData.isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: likeData.isLiked
                                        ? colorScheme.error
                                        : colorScheme.onSurface,
                                  ),
                                ),
                                loading: () => SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: colorScheme.primary,
                                  ),
                                ),
                                error: (_, __) => Icon(
                                  Icons.favorite_border,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(width: 6),

                              // Like count from provider
                              likeDataAsync.when(
                                data: (likeData) => Text(
                                  likeData.likesCount.toString(),
                                  style: textTheme.bodyMedium,
                                ),
                                loading: () =>
                                    Text("...", style: textTheme.bodyMedium),
                                error: (_, __) =>
                                    Text("0", style: textTheme.bodyMedium),
                              ),
                            ],
                          ),

                          const SizedBox(width: 16),

                          // Comments section
                          Row(
                            children: [
                              Icon(
                                Icons.chat_bubble_outline_rounded,
                                size: 18,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "${widget.post.commentsCount} comments",
                                style: textTheme.labelMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),

                          // Share button
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.share_outlined,
                              size: 18,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),

                          const SizedBox(width: 16),

                          // Bookmark button
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.bookmark_border_rounded,
                              size: 18,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
