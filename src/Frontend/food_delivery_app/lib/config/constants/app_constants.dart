/// App Constants
class AppConstants {
  // API Endpoints (replace with actual URLs)
  static const String baseUrl = 'https://api.fooddelivery.com';
  static const String foodDetailEndpoint = '/api/food';
  static const String favoritesEndpoint = '/api/favorites';
  static const String reviewsEndpoint = '/api/reviews';

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration debouceDuration = Duration(milliseconds: 500);

  // Pagination
  static const int pageSize = 10;
  static const int initialPage = 1;

  // Errors
  static const String networkErrorMessage = 'Lỗi kết nối. Vui lòng thử lại.';
  static const String unknownErrorMessage = 'Có lỗi xảy ra. Vui lòng thử lại.';
  static const String noDataErrorMessage = 'Không tìm thấy dữ liệu.';

  // Success Messages
  static const String addedToFavoritesMessage = 'Đã thêm vào yêu thích';
  static const String removedFromFavoritesMessage = 'Đã xóa khỏi yêu thích';
  static const String reviewDeletedMessage = 'Đã xóa đánh giá';
  static const String reviewAddedMessage = 'Đã thêm đánh giá';

  // Validation
  static const int minReviewLength = 10;
  static const int maxReviewLength = 500;
  static const int minRating = 1;
  static const int maxRating = 5;

  // Cache Duration
  static const Duration cacheDuration = Duration(hours: 1);

  // UI Delays
  static const Duration loadingDelay = Duration(milliseconds: 300);
  static const Duration snackBarDuration = Duration(seconds: 2);
}
