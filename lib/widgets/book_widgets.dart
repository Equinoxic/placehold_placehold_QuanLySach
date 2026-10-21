import 'package:flutter/material.dart';

Color statusColor(String status) {
  return switch (status) {
    'Đã đọc' => const Color(0xFF2F7D55),
    'Đang đọc' => const Color(0xFFB66A13),
    _ => const Color(0xFF69736D),
  };
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final color = statusColor(status);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
        child: Text(
          status,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class BookRating extends StatelessWidget {
  const BookRating({
    super.key,
    required this.rating,
    this.onChanged,
    this.iconSize = 20,
  });

  final int rating;
  final ValueChanged<int>? onChanged;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Đánh giá $rating trên 5 sao',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          final selected = index < rating;
          return IconButton(
            onPressed: onChanged == null ? null : () => onChanged!(index + 1),
            visualDensity: VisualDensity.compact,
            constraints: BoxConstraints.tightFor(
              width: iconSize + 8,
              height: iconSize + 8,
            ),
            padding: EdgeInsets.zero,
            tooltip: '${index + 1} sao',
            icon: Icon(
              selected ? Icons.star_rounded : Icons.star_outline_rounded,
              size: iconSize,
              color: selected ? const Color(0xFFE0A32E) : Colors.black26,
            ),
          );
        }),
      ),
    );
  }
}

class PageContent extends StatelessWidget {
  const PageContent({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: child,
      ),
    );
  }
}
