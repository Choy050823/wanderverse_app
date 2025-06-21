import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscussionSidebar extends StatefulWidget {
  final String currentDestination;
  const DiscussionSidebar({required this.currentDestination, super.key});

  @override
  State<DiscussionSidebar> createState() => _DiscussionSidebarState();
}

class _DiscussionSidebarState extends State<DiscussionSidebar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Updated community card
        Card(
          clipBehavior: Clip.antiAlias,
          shape: Theme.of(context).cardTheme.shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
          elevation: Theme.of(context).cardTheme.elevation ?? 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner image with overlay
              Stack(
                children: [
                  // Banner image
                  Container(
                    height: 160,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://wanderverse-cloud-bucket.s3.ap-southeast-1.amazonaws.com/paris.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Elegant overlay gradient
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.8),
                        ],
                        stops: const [0.4, 1.0],
                      ),
                    ),
                  ),
                  // Destination name with travel-themed decoration
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "DESTINATION",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                  color: Colors.black87,
                                ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.currentDestination,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.1,
                              ),
                        ),
                      ],
                    ),
                  ),
                  // Follow button
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Follow",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Community description with theme-aware styling
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "The City of Light awaits you",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Join our community of travelers to discover the magic of Paris. Share your experiences, ask questions, and connect with fellow adventurers exploring the romantic streets of Paris.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                            height: 1.5,
                          ),
                    ),
                  ],
                ),
              ),

              // Community stats with travel-themed layout
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    // .withOpacity(
                    //     Theme.of(context).brightness == Brightness.light
                    //         ? 0.5
                    //         : 1.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTravelStatsColumn("14K", "Travelers", Icons.people),
                      _buildStatsColumnDivider(),
                      _buildTravelStatsColumn("209", "Online", Icons.circle,
                          isOnline: true),
                      _buildStatsColumnDivider(),
                      _buildTravelStatsColumn("5.2K", "Stories", Icons.article),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Updated community rules card
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.shield_outlined,
                      size: 20,
                      color: Color(0xFF4F46E5),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Community Guidelines",
                        style: GoogleFonts.playfairDisplay(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          // color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTravelRuleItem(
                  "1",
                  "Be respectful and inclusive of all travelers",
                  Icons.people_outline,
                ),
                _buildTravelRuleItem(
                  "2",
                  "Share authentic experiences and genuine photos",
                  Icons.verified_outlined,
                ),
                _buildTravelRuleItem(
                  "3",
                  "No spam, advertisements or self-promotion",
                  Icons.block,
                ),
                _buildTravelRuleItem(
                  "4",
                  "Include relevant details in your posts",
                  Icons.info_outline,
                ),
                _buildTravelRuleItem(
                  "5",
                  "Keep content relevant to travel and tourism",
                  Icons.map_outlined,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Updated popular tags card
        // Card(
        //   elevation: 0,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(16),
        //     side: BorderSide(color: Colors.grey.shade200),
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.all(20),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Row(
        //           children: [
        //             const Icon(
        //               Icons.explore,
        //               size: 20,
        //               color: Color(0xFF4F46E5),
        //             ),
        //             const SizedBox(width: 10),
        //             Text(
        //               "Explore Paris",
        //               style: GoogleFonts.playfairDisplay(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 18,
        //                 // color: Colors.black87,
        //               ),
        //             ),
        //           ],
        //         ),
        //         const SizedBox(height: 16),
        //         Wrap(
        //           spacing: 8,
        //           runSpacing: 8,
        //           children: [
        //             _buildTagChip("Eiffel Tower"),
        //             _buildTagChip("Food Guide"),
        //             _buildTagChip("Museums"),
        //             _buildTagChip("Transport"),
        //             _buildTagChip("Accommodations"),
        //             _buildTagChip("Photography"),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildTravelStatsColumn(String value, String label, IconData icon,
      {bool isOnline = false}) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isOnline ? colorScheme.secondary : colorScheme.primary,
            ),
            const SizedBox(width: 6),
            Text(
              value,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsColumnDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
    );
  }

  Widget _buildTravelRuleItem(String number, String rule, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFE0E7FF),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              icon,
              size: 16,
              color: const Color(0xFF4F46E5),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              rule,
              style: GoogleFonts.notoSans(
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
