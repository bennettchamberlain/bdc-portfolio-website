class Resume {
  String url;
  // String date;

  Resume({required this.url});

  factory Resume.fromMap(Map<String, dynamic> json) => Resume(
        url: json["url"],
        //date: json["date"],
      );
}
