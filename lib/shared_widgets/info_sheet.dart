import 'package:flutter/material.dart';

class InfoSheet extends StatelessWidget {
  const InfoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'About This Project',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        // Content
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              _buildInfoSection(
                context,
                'Authentication',
                'This app uses Firebase Anonymous Authentication. When you first open the app, you automatically get a unique user ID. The first few characters of your ID are used as your display name on messages.',
                Icons.person_outline,
              ),
              const SizedBox(height: 20),
              _buildInfoSection(
                context,
                'Message History',
                'Only messages from the last 7 days are displayed. Messages are ordered by most recent on top.',
                Icons.schedule,
              ),
              const SizedBox(height: 20),
              _buildInfoSection(
                context,
                'Real-time Updates',
                'Messages appear instantly for all users. Implemented w/ Firebase Firestore\'s streams.',
                Icons.sync,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(
    BuildContext context,
    String title,
    String description,
    IconData icon,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
