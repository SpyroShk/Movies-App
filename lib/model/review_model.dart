import 'dart:convert';

class Review {
  String author;
  String comment;
  double rating;
  Review({
    required this.author,
    required this.comment,
    required this.rating,
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      author: map['author'] ?? '',
      comment: map['content'] ?? '',
      rating: map['author_details']['rating']?.toDouble() ?? 0.0,
    );
  }
  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));
}
