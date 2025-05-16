import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
class User with _$User {
  factory User(
      {required String id,
      required String username,
      required String email,
      String? description,
      String? profilePicUrl,
      required int gamePoints,
      required DateTime createdAt,
      required DateTime updatedAt
    }) = _User;

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class Post with _$Post {
  factory Post(
      {required String id,
      required String title,
      required String content,
      required List<String> imageUrls,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String creatorId,
      required int likesCount,
      required int commentsCount,
      required List<String> tags}) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

@freezed
class Comment with _$Comment {
  factory Comment(
      {required String id,
      required String postId,
      required String content,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String creatorId}) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
} 

@freezed
class Like with _$Like {
  factory Like(
      {required String id,
      required String postId,
      required String userId,
      required DateTime createdAt}) = _Like;

  factory Like.fromJson(Map<String, dynamic> json) => _$LikeFromJson(json);
}

@freezed
class Destination with _$Destination {
  factory Destination(
      {required String id,
      required String name,
      required String description,
      required String imageUrl,
      required DateTime createdAt,
      required DateTime updatedAt}) = _Destination;

  factory Destination.fromJson(Map<String, dynamic> json) => _$DestinationFromJson(json);
}
