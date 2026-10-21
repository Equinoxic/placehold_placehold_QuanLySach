import 'package:flutter/material.dart';

import '../models/book.dart';
import '../providers/book_provider.dart';
import '../widgets/book_widgets.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key, required this.bookProvider});

  final BookProvider bookProvider;

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  static const _categories = [
    'Văn học',
    'Khoa học',
    'Công nghệ',
    'Kỹ năng sống',
    'Khác',
  ];
  static const _statuses = ['Chưa đọc', 'Đang đọc', 'Đã đọc'];

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _notesController = TextEditingController();
  String _category = _categories.first;
  String _status = _statuses.first;
  int _rating = 0;

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveBook() {
    if (!_formKey.currentState!.validate()) return;
    final book = Book(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      author: _authorController.text.trim(),
      category: _category,
      status: _status,
      rating: _rating,
      notes: _notesController.text.trim(),
    );
    widget.bookProvider.addBook(book);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã thêm sách vào tủ sách của bạn')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm sách mới')),
      body: SafeArea(
        child: PageContent(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
              children: [
                Text(
                  'Thông tin sách',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                Text(
                  'Lưu lại cuốn sách tiếp theo trong hành trình của bạn.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _titleController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Tên sách',
                    prefixIcon: Icon(Icons.menu_book_outlined),
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Vui lòng nhập tên sách'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _authorController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Tác giả',
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Vui lòng nhập tên tác giả'
                      : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _category,
                  decoration: const InputDecoration(
                    labelText: 'Thể loại',
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                  items: _categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => _category = value);
                  },
                ),
                const SizedBox(height: 22),
                Text(
                  'Trạng thái đọc',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                SegmentedButton<String>(
                  segments: _statuses
                      .map(
                        (status) => ButtonSegment(
                          value: status,
                          label: Text(status),
                        ),
                      )
                      .toList(),
                  selected: {_status},
                  showSelectedIcon: false,
                  onSelectionChanged: (selected) =>
                      setState(() => _status = selected.first),
                ),
                const SizedBox(height: 22),
                Text(
                  'Đánh giá của bạn',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    BookRating(
                      rating: _rating,
                      onChanged: (rating) => setState(() => _rating = rating),
                      iconSize: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _rating == 0 ? 'Chưa đánh giá' : '$_rating / 5',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _notesController,
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Ghi chú (không bắt buộc)',
                    alignLabelWithHint: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(bottom: 42),
                      child: Icon(Icons.notes_rounded),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _saveBook,
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Lưu sách'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
