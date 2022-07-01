class Item {
  final String id;
  final String title;
  final String imageUrl;
  final String price;
  final String description;
  final String address;
  final String phoneNumber;

  Item(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.description,
      required this.price,
      required this.address,
      required this.phoneNumber});
}
