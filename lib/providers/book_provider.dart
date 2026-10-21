import 'package:flutter/foundation.dart';

import '../models/book.dart';

class BookProvider extends ChangeNotifier {
  final List<Book> _books = [
    const Book(
      id: 'seed-android',
      title: 'Lập trình Android cơ bản',
      author: 'Nguyễn Văn A',
      category: 'Công nghệ',
      status: 'Đang đọc',
      rating: 4,
      notes: 'Sách dành cho người mới bắt đầu',
    ),
    const Book(
      id: 'seed-dac-nhan-tam',
      title: 'Đắc nhân tâm',
      author: 'Dale Carnegie',
      category: 'Kỹ năng sống',
      status: 'Đã đọc',
      rating: 5,
    ),
    const Book(
      id: 'seed-de-men',
      title: 'Dế Mèn phiêu lưu ký',
      author: 'Tô Hoài',
      category: 'Văn học',
    ),
  ];

  List<Book> get books => List.unmodifiable(_books);

  int get totalBooks => _books.length;

  int get readBooksCount =>
      _books.where((book) => book.status == 'Đã đọc').length;

  int get unreadBooksCount =>
      _books.where((book) => book.status != 'Đã đọc').length;

  Book? bookById(String id) {
    for (final book in _books) {
      if (book.id == id) return book;
    }
    return null;
  }

  void addBook(Book book) {
    _books.insert(0, book);
    notifyListeners();
  }

  void markAsRead(String id) {
    final index = _books.indexWhere((book) => book.id == id);
    if (index == -1 || _books[index].status == 'Đã đọc') return;
    _books[index] = _books[index].copyWith(status: 'Đã đọc');
    notifyListeners();
  }

  void deleteBook(String id) {
    final index = _books.indexWhere((book) => book.id == id);
    if (index == -1) return;
    _books.removeAt(index);
    notifyListeners();
  }
}
