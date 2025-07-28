import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
class User with _$User {
  factory User({
    required String id,
    required String username,
    required String email,
    String? description,
    String? profilePicUrl,
    required List<String> badgesUrls,
    required int gamePoints,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class Post with _$Post {
  factory Post({
    required String id,
    required String title,
    required String content,
    required PostType postType,
    required List<String> imageUrls,
    required DateTime createdAt,
    required DateTime updatedAt,
    required User creator,
    required int likesCount,
    required int commentsCount,
    required Destination destination,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

enum PostType { post, experience, questions, tips }

enum TravelMode { DRIVING, WALKING }

extension PostTypeExtension on PostType {
  String toJson() {
    switch (this) {
      case PostType.post:
        return 'post';
      case PostType.experience:
        return 'experience';
      case PostType.questions:
        return 'questions';
      case PostType.tips:
        return 'tips';
    }
  }
}

@freezed
class Comment with _$Comment {
  factory Comment({
    required String id,
    required String postId,
    required String content,
    required List<Comment> replies,
    required DateTime createdAt,
    required User user,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

@freezed
class Like with _$Like {
  factory Like({
    required String id,
    required String postId,
    required String userId,
    required DateTime createdAt,
  }) = _Like;

  factory Like.fromJson(Map<String, dynamic> json) => _$LikeFromJson(json);
}

@freezed
class Destination with _$Destination {
  factory Destination({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Destination;

  factory Destination.fromJson(Map<String, dynamic> json) =>
      _$DestinationFromJson(json);
}

@freezed
class TripPlan with _$TripPlan {
  factory TripPlan({
    required String planTitle,
    required String overview,
    required List<String> warnings,
    required DateTime tripStartDate,
    required DateTime tripEndDate,
    required List<DailyItinerary> dailyItineraryList,
  }) = _TripPlan;

  // Factory constructor for parsing JSON.
  factory TripPlan.fromJson(Map<String, dynamic> json) =>
      _$TripPlanFromJson(json);
}

@freezed
class DailyItinerary with _$DailyItinerary {
  factory DailyItinerary({
    required DateTime date,
    required String daySummary,
    String? warnings,
    required List<TripActivity> activityList,
  }) = _DailyItinerary;

  factory DailyItinerary.fromJson(Map<String, dynamic> json) =>
      _$DailyItineraryFromJson(json);
}

enum ActivityType { destination, travel }

@freezed
class TripActivity with _$TripActivity {
  factory TripActivity({
    required ActivityType activityType,
    required DateTime estimatedStartTime,
    required DateTime estimatedEndTime,
    LocationDetails? locationDetails,
    TravelDetails? travelDetails,
  }) = _TripActivity;

  factory TripActivity.fromJson(Map<String, dynamic> json) =>
      _$TripActivityFromJson(json);
}

@freezed
class LocationDetails with _$LocationDetails {
  factory LocationDetails({
    required String placeId,
    required String name,
    String? editorialSummary,
    String? formattedAddress,
    @Default([]) List<String> openingHours,
    @Default(0.0) double rating,
    String? website,
    String? phoneNumber,
    String? locationUrl,
    String? locationImageUrl,
  }) = _LocationDetails;

  factory LocationDetails.fromJson(Map<String, dynamic> json) =>
      _$LocationDetailsFromJson(json);
}

@freezed
class TravelDetails with _$TravelDetails {
  factory TravelDetails({
    required String origin,
    required String destination,
    required TravelMode mode,
    required int durationMinutes,
    required double distanceKm,
  }) = _TravelDetails;

  factory TravelDetails.fromJson(Map<String, dynamic> json) =>
      _$TravelDetailsFromJson(json);
}
