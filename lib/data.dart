class data {
  final int id;
  final String thumbnail;
  final String title;
  final String description;
  final int price;
  final double? discountPercentage;
  final String brand;
  // final double? rating;
  final List<dynamic> images;

  data({
    required this.id,
    required this.thumbnail,
    required this.title,
    required this.description,
    required this.price ,
    required this.discountPercentage,
    // required this.rating,
    required this.images,
    required this.brand,
  });
}
