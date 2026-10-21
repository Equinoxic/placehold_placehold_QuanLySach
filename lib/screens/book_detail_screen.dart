import 'package:flutter/material.dart';

import '../providers/book_provider.dart';
import '../widgets/book_widgets.dart';

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({
    super.key,
    required this.bookProvider,
    required this.bookId,
  });

  final BookProvider bookProvider;
  final String bookId;

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa sách?'),
        content: const Text(
          'Bạn có chắc chắn muốn xóa cuốn sách này khỏi tủ sách?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Hủy'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Xóa sách'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      bookProvider.deleteBook(bookId);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết sách')),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: bookProvider,
          builder: (context, _) {
            final book = bookProvider.bookById(bookId);
            if (book == null) {
              return const Center(child: Text('Không tìm thấy sách.'));
            }
            return PageContent(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 64,
                            height: 76,
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              Icons.menu_book_rounded,
                              color: Theme.of(context).colorScheme.primary,
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            book.title,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tác giả: ${book.author}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Thể loại: ${book.category}',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                          const SizedBox(height: 18),
                          StatusBadge(status: book.status),
                          const SizedBox(height: 18),
                          BookRating(rating: book.rating, iconSize: 25),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ghi chú',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            book.notes.isEmpty
                                ? 'Chưa có ghi chú cho cuốn sách này.'
                                : book.notes,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: book.notes.isEmpty
                                      ? Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant
                                      : null,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  if (book.status != 'Đã đọc')
                    FilledButton.icon(
                      onPressed: () => bookProvider.markAsRead(bookId),
                      icon: const Icon(Icons.check_rounded),
                      label: const Text('Đánh dấu đã đọc'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                      ),
                    ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () => _confirmDelete(context),
                    icon: const Icon(Icons.delete_outline_rounded),
                    label: const Text('Xóa sách'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                      minimumSize: const Size.fromHeight(52),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
