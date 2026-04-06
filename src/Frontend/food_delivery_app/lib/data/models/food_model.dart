/// Represents a food item displayed on the home screen and restaurant detail screen.
class FoodModel {
  final String id;
  final String name;
  final String price;
  final String imageUrl;

  const FoodModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}
