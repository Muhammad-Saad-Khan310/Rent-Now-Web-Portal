class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  @override
  String toString() {
    return message;
    // ignore: todo
    // TODO: implement toString
    // return super.toString();
  }
}
