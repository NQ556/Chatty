import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description({
    super.key,
    required this.description,
  });
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divider
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Divider(
            color: Colors.black.withOpacity(0.5),
          ),
        ),

        // Description
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            description,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ),

        // Divider
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Divider(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
