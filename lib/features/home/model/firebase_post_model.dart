class FirebasePost {
  final String documentId;
  final String subreddit;
  final String title;
  final String selfText;
  final String permalink;

  FirebasePost({
    required this.documentId,
    required this.subreddit,
    required this.title,
    required this.selfText,
    required this.permalink,
  });

  factory FirebasePost.fromMap(Map<String, dynamic> map) {
    return FirebasePost(
      documentId: map['documentId'],
      subreddit: map['subreddit'],
      title: map['title'],
      selfText: map['selfText'],
      permalink: map['permalink'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'documentId': documentId,
      'subreddit': subreddit,
      'title': title,
      'selfText': selfText,
      'permalink': permalink,
    };
  }
}
