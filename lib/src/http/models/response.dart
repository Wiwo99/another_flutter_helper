class Response {
  final int statusCode;
  final String body;
  final Map<String, String> headers;

  Response(this.statusCode, this.body, this.headers);

  @override
  int get hashCode => statusCode.hashCode ^ body.hashCode ^ headers.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Response &&
          runtimeType == other.runtimeType &&
          statusCode == other.statusCode &&
          body == other.body &&
          headers == other.headers;

  Response copyWith({
    int? statusCode,
    String? body,
    Map<String, String>? headers,
  }) {
    return Response(
      statusCode ?? this.statusCode,
      body ?? this.body,
      headers ?? this.headers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'body': body,
      'headers': headers,
    };
  }

  @override
  String toString() {
    return 'Response{statusCode: $statusCode, body: $body, headers: $headers}';
  }

  static Response fromJson(Map<String, dynamic> json) {
    return Response(
      json['statusCode'] as int,
      json['body'] as String,
      json['headers'] as Map<String, String>,
    );
  }
}
