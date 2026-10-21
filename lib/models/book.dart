class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    this.category = 'Văn học',
    this.status = 'Chưa đọc',
    this.rating = 0,
    this.notes = '',
  }) : assert(rating >= 0 && rating <= 5);

  final String id;
  final String title;
  final String author;
  final String category;
  final String status;
  final int rating;
  final String notes;

  Book copyWith({
    String? title,
    String? author,
    String? category,
    String? status,
    int? rating,
    String? notes,
  }) {
    return Book(
      id: id,
      title: title ?? this.title,
      author: author ?? this.author,
      category: category ?? this.category,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      notes: notes ?? this.notes,
    );
  }
}
