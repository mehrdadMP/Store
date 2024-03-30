class CommentEntity {
  final int id;
  final String title;
  final String content;
  final String date;
  final String email;

  CommentEntity.fromJason(Map<String, dynamic> jason)
      : id = jason['id'],
        title = jason['title'],
        content = jason['content'],
        date = jason['date'],
        email = jason['author']['email'];
}
