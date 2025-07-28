import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ItineraryCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final String imageUrl;
  final String? address;
  final double? rating;
  final String? phoneNumber;
  final String? website;
  final List<String>? openingHours;
  final Map<String, dynamic>? additionalInfo;
  final String? locationUrl; // Add this field

  const ItineraryCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.imageUrl,
    this.address,
    this.rating,
    this.phoneNumber,
    this.website,
    this.openingHours,
    this.additionalInfo,
    this.locationUrl, // Add this parameter
  });

  // Add a method to launch URLs
  Future<void> _launchUrl(String? urlString) async {
    if (urlString == null || urlString.isEmpty) return;

    final Uri url = Uri.parse(urlString);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero, // Remove margin
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with title and image
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                      ),
                      if (rating != null) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              rating!.toStringAsFixed(1),
                              style: textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 90,
                    height: 90,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: colorScheme.surfaceVariant,
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: colorScheme.outline,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              description,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.outline,
                height: 1.5,
              ),
            ),

            // Address
            if (address != null && address!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on, size: 16, color: colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      address!,
                      style: textTheme.bodySmall,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],

            // Phone
            if (phoneNumber != null && phoneNumber!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.phone, size: 16, color: colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(phoneNumber!, style: textTheme.bodySmall),
                ],
              ),
            ],

            // Website
            if (website != null && website!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.language, size: 16, color: colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      website!,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],

            // Opening Hours
            if (openingHours != null && openingHours!.isNotEmpty) ...[
              const SizedBox(height: 12),
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(
                  'Opening Hours',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                children: openingHours!
                    .map(
                      (hours) => Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('•', style: textTheme.bodySmall),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(hours, style: textTheme.bodySmall),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],

            // Time chip
            if (time.isNotEmpty) ...[
              const SizedBox(height: 16),
              Chip(
                label: Text(time),
                labelStyle: textTheme.labelLarge?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
                backgroundColor: colorScheme.primary.withOpacity(0.1),
                visualDensity: VisualDensity.compact,
              ),
            ],

            // Additional Info
            if (additionalInfo != null && additionalInfo!.isNotEmpty) ...[
              const SizedBox(height: 12),
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(
                  'Additional Information',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                children: additionalInfo!.entries
                    .map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${entry.key}:',
                              style: textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                entry.value.toString(),
                                style: textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],

            // Add Directions button if locationUrl is available
            if (locationUrl != null && locationUrl!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _launchUrl(locationUrl),
                    icon: const Icon(Icons.directions),
                    label: const Text('Directions'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
