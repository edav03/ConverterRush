const String tablePages = 'pages_data';

class PageFields {
  static final List<String> values = [id, htmlContent];

  static const String id = '_id';
  static const String htmlContent = 'htmlContent';
}

class PageData {
  int id;
  String? htmlContent;

  PageData({required this.id, this.htmlContent});

  PageData copy({int? id, String? htmlContent}) => PageData(
        id: id ?? this.id,
        htmlContent: htmlContent ?? this.htmlContent,
      );

  static PageData fromJson(Map<String, Object?> json) => PageData(
        id: json[PageFields.id] as int,
        htmlContent: json[PageFields.htmlContent] as String,
      );

  Map<String, Object?> toJson() => {
        PageFields.id: id,
        PageFields.htmlContent: htmlContent,
      };
}
