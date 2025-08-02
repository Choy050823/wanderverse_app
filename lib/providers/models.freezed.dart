// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get profilePicUrl => throw _privateConstructorUsedError;
  List<String> get badgesUrls => throw _privateConstructorUsedError;
  int get gamePoints => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String id,
      String username,
      String email,
      String? description,
      String? profilePicUrl,
      List<String> badgesUrls,
      int gamePoints,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? description = freezed,
    Object? profilePicUrl = freezed,
    Object? badgesUrls = null,
    Object? gamePoints = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicUrl: freezed == profilePicUrl
          ? _value.profilePicUrl
          : profilePicUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      badgesUrls: null == badgesUrls
          ? _value.badgesUrls
          : badgesUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      gamePoints: null == gamePoints
          ? _value.gamePoints
          : gamePoints // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String username,
      String email,
      String? description,
      String? profilePicUrl,
      List<String> badgesUrls,
      int gamePoints,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? description = freezed,
    Object? profilePicUrl = freezed,
    Object? badgesUrls = null,
    Object? gamePoints = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicUrl: freezed == profilePicUrl
          ? _value.profilePicUrl
          : profilePicUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      badgesUrls: null == badgesUrls
          ? _value._badgesUrls
          : badgesUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      gamePoints: null == gamePoints
          ? _value.gamePoints
          : gamePoints // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  _$UserImpl(
      {required this.id,
      required this.username,
      required this.email,
      this.description,
      this.profilePicUrl,
      required final List<String> badgesUrls,
      required this.gamePoints,
      required this.createdAt,
      required this.updatedAt})
      : _badgesUrls = badgesUrls;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String username;
  @override
  final String email;
  @override
  final String? description;
  @override
  final String? profilePicUrl;
  final List<String> _badgesUrls;
  @override
  List<String> get badgesUrls {
    if (_badgesUrls is EqualUnmodifiableListView) return _badgesUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_badgesUrls);
  }

  @override
  final int gamePoints;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, description: $description, profilePicUrl: $profilePicUrl, badgesUrls: $badgesUrls, gamePoints: $gamePoints, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.profilePicUrl, profilePicUrl) ||
                other.profilePicUrl == profilePicUrl) &&
            const DeepCollectionEquality()
                .equals(other._badgesUrls, _badgesUrls) &&
            (identical(other.gamePoints, gamePoints) ||
                other.gamePoints == gamePoints) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      username,
      email,
      description,
      profilePicUrl,
      const DeepCollectionEquality().hash(_badgesUrls),
      gamePoints,
      createdAt,
      updatedAt);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  factory _User(
      {required final String id,
      required final String username,
      required final String email,
      final String? description,
      final String? profilePicUrl,
      required final List<String> badgesUrls,
      required final int gamePoints,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get username;
  @override
  String get email;
  @override
  String? get description;
  @override
  String? get profilePicUrl;
  @override
  List<String> get badgesUrls;
  @override
  int get gamePoints;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  PostType get postType => throw _privateConstructorUsedError;
  List<String> get imageUrls => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  User get creator => throw _privateConstructorUsedError;
  int get likesCount => throw _privateConstructorUsedError;
  int get commentsCount => throw _privateConstructorUsedError;
  Destination get destination => throw _privateConstructorUsedError;

  /// Serializes this Post to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res, Post>;
  @useResult
  $Res call(
      {String id,
      String title,
      String content,
      PostType postType,
      List<String> imageUrls,
      DateTime createdAt,
      DateTime updatedAt,
      User creator,
      int likesCount,
      int commentsCount,
      Destination destination});

  $UserCopyWith<$Res> get creator;
  $DestinationCopyWith<$Res> get destination;
}

/// @nodoc
class _$PostCopyWithImpl<$Res, $Val extends Post>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? postType = null,
    Object? imageUrls = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? creator = null,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? destination = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      postType: null == postType
          ? _value.postType
          : postType // ignore: cast_nullable_to_non_nullable
              as PostType,
      imageUrls: null == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as User,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentsCount: null == commentsCount
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as Destination,
    ) as $Val);
  }

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get creator {
    return $UserCopyWith<$Res>(_value.creator, (value) {
      return _then(_value.copyWith(creator: value) as $Val);
    });
  }

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DestinationCopyWith<$Res> get destination {
    return $DestinationCopyWith<$Res>(_value.destination, (value) {
      return _then(_value.copyWith(destination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostImplCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$PostImplCopyWith(
          _$PostImpl value, $Res Function(_$PostImpl) then) =
      __$$PostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String content,
      PostType postType,
      List<String> imageUrls,
      DateTime createdAt,
      DateTime updatedAt,
      User creator,
      int likesCount,
      int commentsCount,
      Destination destination});

  @override
  $UserCopyWith<$Res> get creator;
  @override
  $DestinationCopyWith<$Res> get destination;
}

/// @nodoc
class __$$PostImplCopyWithImpl<$Res>
    extends _$PostCopyWithImpl<$Res, _$PostImpl>
    implements _$$PostImplCopyWith<$Res> {
  __$$PostImplCopyWithImpl(_$PostImpl _value, $Res Function(_$PostImpl) _then)
      : super(_value, _then);

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? postType = null,
    Object? imageUrls = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? creator = null,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? destination = null,
  }) {
    return _then(_$PostImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      postType: null == postType
          ? _value.postType
          : postType // ignore: cast_nullable_to_non_nullable
              as PostType,
      imageUrls: null == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as User,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentsCount: null == commentsCount
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as Destination,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostImpl implements _Post {
  _$PostImpl(
      {required this.id,
      required this.title,
      required this.content,
      required this.postType,
      required final List<String> imageUrls,
      required this.createdAt,
      required this.updatedAt,
      required this.creator,
      required this.likesCount,
      required this.commentsCount,
      required this.destination})
      : _imageUrls = imageUrls;

  factory _$PostImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String content;
  @override
  final PostType postType;
  final List<String> _imageUrls;
  @override
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final User creator;
  @override
  final int likesCount;
  @override
  final int commentsCount;
  @override
  final Destination destination;

  @override
  String toString() {
    return 'Post(id: $id, title: $title, content: $content, postType: $postType, imageUrls: $imageUrls, createdAt: $createdAt, updatedAt: $updatedAt, creator: $creator, likesCount: $likesCount, commentsCount: $commentsCount, destination: $destination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.postType, postType) ||
                other.postType == postType) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.commentsCount, commentsCount) ||
                other.commentsCount == commentsCount) &&
            (identical(other.destination, destination) ||
                other.destination == destination));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      content,
      postType,
      const DeepCollectionEquality().hash(_imageUrls),
      createdAt,
      updatedAt,
      creator,
      likesCount,
      commentsCount,
      destination);

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      __$$PostImplCopyWithImpl<_$PostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostImplToJson(
      this,
    );
  }
}

abstract class _Post implements Post {
  factory _Post(
      {required final String id,
      required final String title,
      required final String content,
      required final PostType postType,
      required final List<String> imageUrls,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final User creator,
      required final int likesCount,
      required final int commentsCount,
      required final Destination destination}) = _$PostImpl;

  factory _Post.fromJson(Map<String, dynamic> json) = _$PostImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get content;
  @override
  PostType get postType;
  @override
  List<String> get imageUrls;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  User get creator;
  @override
  int get likesCount;
  @override
  int get commentsCount;
  @override
  Destination get destination;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
mixin _$Comment {
  String get id => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<Comment> get replies => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  User get user => throw _privateConstructorUsedError;

  /// Serializes this Comment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res, Comment>;
  @useResult
  $Res call(
      {String id,
      String postId,
      String content,
      List<Comment> replies,
      DateTime createdAt,
      User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$CommentCopyWithImpl<$Res, $Val extends Comment>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? content = null,
    Object? replies = null,
    Object? createdAt = null,
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      replies: null == replies
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ) as $Val);
  }

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CommentImplCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$$CommentImplCopyWith(
          _$CommentImpl value, $Res Function(_$CommentImpl) then) =
      __$$CommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String postId,
      String content,
      List<Comment> replies,
      DateTime createdAt,
      User user});

  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$CommentImplCopyWithImpl<$Res>
    extends _$CommentCopyWithImpl<$Res, _$CommentImpl>
    implements _$$CommentImplCopyWith<$Res> {
  __$$CommentImplCopyWithImpl(
      _$CommentImpl _value, $Res Function(_$CommentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? content = null,
    Object? replies = null,
    Object? createdAt = null,
    Object? user = null,
  }) {
    return _then(_$CommentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      replies: null == replies
          ? _value._replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentImpl implements _Comment {
  _$CommentImpl(
      {required this.id,
      required this.postId,
      required this.content,
      required final List<Comment> replies,
      required this.createdAt,
      required this.user})
      : _replies = replies;

  factory _$CommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentImplFromJson(json);

  @override
  final String id;
  @override
  final String postId;
  @override
  final String content;
  final List<Comment> _replies;
  @override
  List<Comment> get replies {
    if (_replies is EqualUnmodifiableListView) return _replies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_replies);
  }

  @override
  final DateTime createdAt;
  @override
  final User user;

  @override
  String toString() {
    return 'Comment(id: $id, postId: $postId, content: $content, replies: $replies, createdAt: $createdAt, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._replies, _replies) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, postId, content,
      const DeepCollectionEquality().hash(_replies), createdAt, user);

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      __$$CommentImplCopyWithImpl<_$CommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentImplToJson(
      this,
    );
  }
}

abstract class _Comment implements Comment {
  factory _Comment(
      {required final String id,
      required final String postId,
      required final String content,
      required final List<Comment> replies,
      required final DateTime createdAt,
      required final User user}) = _$CommentImpl;

  factory _Comment.fromJson(Map<String, dynamic> json) = _$CommentImpl.fromJson;

  @override
  String get id;
  @override
  String get postId;
  @override
  String get content;
  @override
  List<Comment> get replies;
  @override
  DateTime get createdAt;
  @override
  User get user;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Like _$LikeFromJson(Map<String, dynamic> json) {
  return _Like.fromJson(json);
}

/// @nodoc
mixin _$Like {
  String get id => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Like to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Like
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LikeCopyWith<Like> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LikeCopyWith<$Res> {
  factory $LikeCopyWith(Like value, $Res Function(Like) then) =
      _$LikeCopyWithImpl<$Res, Like>;
  @useResult
  $Res call({String id, String postId, String userId, DateTime createdAt});
}

/// @nodoc
class _$LikeCopyWithImpl<$Res, $Val extends Like>
    implements $LikeCopyWith<$Res> {
  _$LikeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Like
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LikeImplCopyWith<$Res> implements $LikeCopyWith<$Res> {
  factory _$$LikeImplCopyWith(
          _$LikeImpl value, $Res Function(_$LikeImpl) then) =
      __$$LikeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String postId, String userId, DateTime createdAt});
}

/// @nodoc
class __$$LikeImplCopyWithImpl<$Res>
    extends _$LikeCopyWithImpl<$Res, _$LikeImpl>
    implements _$$LikeImplCopyWith<$Res> {
  __$$LikeImplCopyWithImpl(_$LikeImpl _value, $Res Function(_$LikeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Like
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_$LikeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LikeImpl implements _Like {
  _$LikeImpl(
      {required this.id,
      required this.postId,
      required this.userId,
      required this.createdAt});

  factory _$LikeImpl.fromJson(Map<String, dynamic> json) =>
      _$$LikeImplFromJson(json);

  @override
  final String id;
  @override
  final String postId;
  @override
  final String userId;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Like(id: $id, postId: $postId, userId: $userId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LikeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, postId, userId, createdAt);

  /// Create a copy of Like
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LikeImplCopyWith<_$LikeImpl> get copyWith =>
      __$$LikeImplCopyWithImpl<_$LikeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LikeImplToJson(
      this,
    );
  }
}

abstract class _Like implements Like {
  factory _Like(
      {required final String id,
      required final String postId,
      required final String userId,
      required final DateTime createdAt}) = _$LikeImpl;

  factory _Like.fromJson(Map<String, dynamic> json) = _$LikeImpl.fromJson;

  @override
  String get id;
  @override
  String get postId;
  @override
  String get userId;
  @override
  DateTime get createdAt;

  /// Create a copy of Like
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LikeImplCopyWith<_$LikeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Destination _$DestinationFromJson(Map<String, dynamic> json) {
  return _Destination.fromJson(json);
}

/// @nodoc
mixin _$Destination {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Destination to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Destination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DestinationCopyWith<Destination> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DestinationCopyWith<$Res> {
  factory $DestinationCopyWith(
          Destination value, $Res Function(Destination) then) =
      _$DestinationCopyWithImpl<$Res, Destination>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String imageUrl,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$DestinationCopyWithImpl<$Res, $Val extends Destination>
    implements $DestinationCopyWith<$Res> {
  _$DestinationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Destination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DestinationImplCopyWith<$Res>
    implements $DestinationCopyWith<$Res> {
  factory _$$DestinationImplCopyWith(
          _$DestinationImpl value, $Res Function(_$DestinationImpl) then) =
      __$$DestinationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String imageUrl,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$DestinationImplCopyWithImpl<$Res>
    extends _$DestinationCopyWithImpl<$Res, _$DestinationImpl>
    implements _$$DestinationImplCopyWith<$Res> {
  __$$DestinationImplCopyWithImpl(
      _$DestinationImpl _value, $Res Function(_$DestinationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Destination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$DestinationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DestinationImpl implements _Destination {
  _$DestinationImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.createdAt,
      required this.updatedAt});

  factory _$DestinationImpl.fromJson(Map<String, dynamic> json) =>
      _$$DestinationImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String imageUrl;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Destination(id: $id, name: $name, description: $description, imageUrl: $imageUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DestinationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, description, imageUrl, createdAt, updatedAt);

  /// Create a copy of Destination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DestinationImplCopyWith<_$DestinationImpl> get copyWith =>
      __$$DestinationImplCopyWithImpl<_$DestinationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DestinationImplToJson(
      this,
    );
  }
}

abstract class _Destination implements Destination {
  factory _Destination(
      {required final String id,
      required final String name,
      required final String description,
      required final String imageUrl,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$DestinationImpl;

  factory _Destination.fromJson(Map<String, dynamic> json) =
      _$DestinationImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get imageUrl;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Destination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DestinationImplCopyWith<_$DestinationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TripPlan _$TripPlanFromJson(Map<String, dynamic> json) {
  return _TripPlan.fromJson(json);
}

/// @nodoc
mixin _$TripPlan {
  String get planTitle => throw _privateConstructorUsedError;
  String get overview => throw _privateConstructorUsedError;
  List<String> get warnings => throw _privateConstructorUsedError;
  DateTime get tripStartDate => throw _privateConstructorUsedError;
  DateTime get tripEndDate => throw _privateConstructorUsedError;
  List<DailyItinerary> get dailyItineraryList =>
      throw _privateConstructorUsedError;

  /// Serializes this TripPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TripPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TripPlanCopyWith<TripPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripPlanCopyWith<$Res> {
  factory $TripPlanCopyWith(TripPlan value, $Res Function(TripPlan) then) =
      _$TripPlanCopyWithImpl<$Res, TripPlan>;
  @useResult
  $Res call(
      {String planTitle,
      String overview,
      List<String> warnings,
      DateTime tripStartDate,
      DateTime tripEndDate,
      List<DailyItinerary> dailyItineraryList});
}

/// @nodoc
class _$TripPlanCopyWithImpl<$Res, $Val extends TripPlan>
    implements $TripPlanCopyWith<$Res> {
  _$TripPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TripPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? planTitle = null,
    Object? overview = null,
    Object? warnings = null,
    Object? tripStartDate = null,
    Object? tripEndDate = null,
    Object? dailyItineraryList = null,
  }) {
    return _then(_value.copyWith(
      planTitle: null == planTitle
          ? _value.planTitle
          : planTitle // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      warnings: null == warnings
          ? _value.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tripStartDate: null == tripStartDate
          ? _value.tripStartDate
          : tripStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tripEndDate: null == tripEndDate
          ? _value.tripEndDate
          : tripEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dailyItineraryList: null == dailyItineraryList
          ? _value.dailyItineraryList
          : dailyItineraryList // ignore: cast_nullable_to_non_nullable
              as List<DailyItinerary>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TripPlanImplCopyWith<$Res>
    implements $TripPlanCopyWith<$Res> {
  factory _$$TripPlanImplCopyWith(
          _$TripPlanImpl value, $Res Function(_$TripPlanImpl) then) =
      __$$TripPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String planTitle,
      String overview,
      List<String> warnings,
      DateTime tripStartDate,
      DateTime tripEndDate,
      List<DailyItinerary> dailyItineraryList});
}

/// @nodoc
class __$$TripPlanImplCopyWithImpl<$Res>
    extends _$TripPlanCopyWithImpl<$Res, _$TripPlanImpl>
    implements _$$TripPlanImplCopyWith<$Res> {
  __$$TripPlanImplCopyWithImpl(
      _$TripPlanImpl _value, $Res Function(_$TripPlanImpl) _then)
      : super(_value, _then);

  /// Create a copy of TripPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? planTitle = null,
    Object? overview = null,
    Object? warnings = null,
    Object? tripStartDate = null,
    Object? tripEndDate = null,
    Object? dailyItineraryList = null,
  }) {
    return _then(_$TripPlanImpl(
      planTitle: null == planTitle
          ? _value.planTitle
          : planTitle // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      warnings: null == warnings
          ? _value._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tripStartDate: null == tripStartDate
          ? _value.tripStartDate
          : tripStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tripEndDate: null == tripEndDate
          ? _value.tripEndDate
          : tripEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dailyItineraryList: null == dailyItineraryList
          ? _value._dailyItineraryList
          : dailyItineraryList // ignore: cast_nullable_to_non_nullable
              as List<DailyItinerary>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripPlanImpl implements _TripPlan {
  _$TripPlanImpl(
      {required this.planTitle,
      required this.overview,
      required final List<String> warnings,
      required this.tripStartDate,
      required this.tripEndDate,
      required final List<DailyItinerary> dailyItineraryList})
      : _warnings = warnings,
        _dailyItineraryList = dailyItineraryList;

  factory _$TripPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripPlanImplFromJson(json);

  @override
  final String planTitle;
  @override
  final String overview;
  final List<String> _warnings;
  @override
  List<String> get warnings {
    if (_warnings is EqualUnmodifiableListView) return _warnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_warnings);
  }

  @override
  final DateTime tripStartDate;
  @override
  final DateTime tripEndDate;
  final List<DailyItinerary> _dailyItineraryList;
  @override
  List<DailyItinerary> get dailyItineraryList {
    if (_dailyItineraryList is EqualUnmodifiableListView)
      return _dailyItineraryList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyItineraryList);
  }

  @override
  String toString() {
    return 'TripPlan(planTitle: $planTitle, overview: $overview, warnings: $warnings, tripStartDate: $tripStartDate, tripEndDate: $tripEndDate, dailyItineraryList: $dailyItineraryList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripPlanImpl &&
            (identical(other.planTitle, planTitle) ||
                other.planTitle == planTitle) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            const DeepCollectionEquality().equals(other._warnings, _warnings) &&
            (identical(other.tripStartDate, tripStartDate) ||
                other.tripStartDate == tripStartDate) &&
            (identical(other.tripEndDate, tripEndDate) ||
                other.tripEndDate == tripEndDate) &&
            const DeepCollectionEquality()
                .equals(other._dailyItineraryList, _dailyItineraryList));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      planTitle,
      overview,
      const DeepCollectionEquality().hash(_warnings),
      tripStartDate,
      tripEndDate,
      const DeepCollectionEquality().hash(_dailyItineraryList));

  /// Create a copy of TripPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripPlanImplCopyWith<_$TripPlanImpl> get copyWith =>
      __$$TripPlanImplCopyWithImpl<_$TripPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TripPlanImplToJson(
      this,
    );
  }
}

abstract class _TripPlan implements TripPlan {
  factory _TripPlan(
      {required final String planTitle,
      required final String overview,
      required final List<String> warnings,
      required final DateTime tripStartDate,
      required final DateTime tripEndDate,
      required final List<DailyItinerary> dailyItineraryList}) = _$TripPlanImpl;

  factory _TripPlan.fromJson(Map<String, dynamic> json) =
      _$TripPlanImpl.fromJson;

  @override
  String get planTitle;
  @override
  String get overview;
  @override
  List<String> get warnings;
  @override
  DateTime get tripStartDate;
  @override
  DateTime get tripEndDate;
  @override
  List<DailyItinerary> get dailyItineraryList;

  /// Create a copy of TripPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripPlanImplCopyWith<_$TripPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyItinerary _$DailyItineraryFromJson(Map<String, dynamic> json) {
  return _DailyItinerary.fromJson(json);
}

/// @nodoc
mixin _$DailyItinerary {
  DateTime get date => throw _privateConstructorUsedError;
  String get daySummary => throw _privateConstructorUsedError;
  String? get warnings => throw _privateConstructorUsedError;
  List<TripActivity> get activityList => throw _privateConstructorUsedError;

  /// Serializes this DailyItinerary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyItinerary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyItineraryCopyWith<DailyItinerary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyItineraryCopyWith<$Res> {
  factory $DailyItineraryCopyWith(
          DailyItinerary value, $Res Function(DailyItinerary) then) =
      _$DailyItineraryCopyWithImpl<$Res, DailyItinerary>;
  @useResult
  $Res call(
      {DateTime date,
      String daySummary,
      String? warnings,
      List<TripActivity> activityList});
}

/// @nodoc
class _$DailyItineraryCopyWithImpl<$Res, $Val extends DailyItinerary>
    implements $DailyItineraryCopyWith<$Res> {
  _$DailyItineraryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyItinerary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? daySummary = null,
    Object? warnings = freezed,
    Object? activityList = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      daySummary: null == daySummary
          ? _value.daySummary
          : daySummary // ignore: cast_nullable_to_non_nullable
              as String,
      warnings: freezed == warnings
          ? _value.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as String?,
      activityList: null == activityList
          ? _value.activityList
          : activityList // ignore: cast_nullable_to_non_nullable
              as List<TripActivity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyItineraryImplCopyWith<$Res>
    implements $DailyItineraryCopyWith<$Res> {
  factory _$$DailyItineraryImplCopyWith(_$DailyItineraryImpl value,
          $Res Function(_$DailyItineraryImpl) then) =
      __$$DailyItineraryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      String daySummary,
      String? warnings,
      List<TripActivity> activityList});
}

/// @nodoc
class __$$DailyItineraryImplCopyWithImpl<$Res>
    extends _$DailyItineraryCopyWithImpl<$Res, _$DailyItineraryImpl>
    implements _$$DailyItineraryImplCopyWith<$Res> {
  __$$DailyItineraryImplCopyWithImpl(
      _$DailyItineraryImpl _value, $Res Function(_$DailyItineraryImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyItinerary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? daySummary = null,
    Object? warnings = freezed,
    Object? activityList = null,
  }) {
    return _then(_$DailyItineraryImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      daySummary: null == daySummary
          ? _value.daySummary
          : daySummary // ignore: cast_nullable_to_non_nullable
              as String,
      warnings: freezed == warnings
          ? _value.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as String?,
      activityList: null == activityList
          ? _value._activityList
          : activityList // ignore: cast_nullable_to_non_nullable
              as List<TripActivity>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyItineraryImpl implements _DailyItinerary {
  _$DailyItineraryImpl(
      {required this.date,
      required this.daySummary,
      this.warnings,
      required final List<TripActivity> activityList})
      : _activityList = activityList;

  factory _$DailyItineraryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyItineraryImplFromJson(json);

  @override
  final DateTime date;
  @override
  final String daySummary;
  @override
  final String? warnings;
  final List<TripActivity> _activityList;
  @override
  List<TripActivity> get activityList {
    if (_activityList is EqualUnmodifiableListView) return _activityList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activityList);
  }

  @override
  String toString() {
    return 'DailyItinerary(date: $date, daySummary: $daySummary, warnings: $warnings, activityList: $activityList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyItineraryImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.daySummary, daySummary) ||
                other.daySummary == daySummary) &&
            (identical(other.warnings, warnings) ||
                other.warnings == warnings) &&
            const DeepCollectionEquality()
                .equals(other._activityList, _activityList));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, daySummary, warnings,
      const DeepCollectionEquality().hash(_activityList));

  /// Create a copy of DailyItinerary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyItineraryImplCopyWith<_$DailyItineraryImpl> get copyWith =>
      __$$DailyItineraryImplCopyWithImpl<_$DailyItineraryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyItineraryImplToJson(
      this,
    );
  }
}

abstract class _DailyItinerary implements DailyItinerary {
  factory _DailyItinerary(
      {required final DateTime date,
      required final String daySummary,
      final String? warnings,
      required final List<TripActivity> activityList}) = _$DailyItineraryImpl;

  factory _DailyItinerary.fromJson(Map<String, dynamic> json) =
      _$DailyItineraryImpl.fromJson;

  @override
  DateTime get date;
  @override
  String get daySummary;
  @override
  String? get warnings;
  @override
  List<TripActivity> get activityList;

  /// Create a copy of DailyItinerary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyItineraryImplCopyWith<_$DailyItineraryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TripActivity _$TripActivityFromJson(Map<String, dynamic> json) {
  return _TripActivity.fromJson(json);
}

/// @nodoc
mixin _$TripActivity {
  ActivityType get activityType => throw _privateConstructorUsedError;
  DateTime get estimatedStartTime => throw _privateConstructorUsedError;
  DateTime get estimatedEndTime => throw _privateConstructorUsedError;
  LocationDetails? get locationDetails => throw _privateConstructorUsedError;
  TravelDetails? get travelDetails => throw _privateConstructorUsedError;

  /// Serializes this TripActivity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TripActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TripActivityCopyWith<TripActivity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripActivityCopyWith<$Res> {
  factory $TripActivityCopyWith(
          TripActivity value, $Res Function(TripActivity) then) =
      _$TripActivityCopyWithImpl<$Res, TripActivity>;
  @useResult
  $Res call(
      {ActivityType activityType,
      DateTime estimatedStartTime,
      DateTime estimatedEndTime,
      LocationDetails? locationDetails,
      TravelDetails? travelDetails});

  $LocationDetailsCopyWith<$Res>? get locationDetails;
  $TravelDetailsCopyWith<$Res>? get travelDetails;
}

/// @nodoc
class _$TripActivityCopyWithImpl<$Res, $Val extends TripActivity>
    implements $TripActivityCopyWith<$Res> {
  _$TripActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TripActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activityType = null,
    Object? estimatedStartTime = null,
    Object? estimatedEndTime = null,
    Object? locationDetails = freezed,
    Object? travelDetails = freezed,
  }) {
    return _then(_value.copyWith(
      activityType: null == activityType
          ? _value.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as ActivityType,
      estimatedStartTime: null == estimatedStartTime
          ? _value.estimatedStartTime
          : estimatedStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      estimatedEndTime: null == estimatedEndTime
          ? _value.estimatedEndTime
          : estimatedEndTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      locationDetails: freezed == locationDetails
          ? _value.locationDetails
          : locationDetails // ignore: cast_nullable_to_non_nullable
              as LocationDetails?,
      travelDetails: freezed == travelDetails
          ? _value.travelDetails
          : travelDetails // ignore: cast_nullable_to_non_nullable
              as TravelDetails?,
    ) as $Val);
  }

  /// Create a copy of TripActivity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationDetailsCopyWith<$Res>? get locationDetails {
    if (_value.locationDetails == null) {
      return null;
    }

    return $LocationDetailsCopyWith<$Res>(_value.locationDetails!, (value) {
      return _then(_value.copyWith(locationDetails: value) as $Val);
    });
  }

  /// Create a copy of TripActivity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TravelDetailsCopyWith<$Res>? get travelDetails {
    if (_value.travelDetails == null) {
      return null;
    }

    return $TravelDetailsCopyWith<$Res>(_value.travelDetails!, (value) {
      return _then(_value.copyWith(travelDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TripActivityImplCopyWith<$Res>
    implements $TripActivityCopyWith<$Res> {
  factory _$$TripActivityImplCopyWith(
          _$TripActivityImpl value, $Res Function(_$TripActivityImpl) then) =
      __$$TripActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ActivityType activityType,
      DateTime estimatedStartTime,
      DateTime estimatedEndTime,
      LocationDetails? locationDetails,
      TravelDetails? travelDetails});

  @override
  $LocationDetailsCopyWith<$Res>? get locationDetails;
  @override
  $TravelDetailsCopyWith<$Res>? get travelDetails;
}

/// @nodoc
class __$$TripActivityImplCopyWithImpl<$Res>
    extends _$TripActivityCopyWithImpl<$Res, _$TripActivityImpl>
    implements _$$TripActivityImplCopyWith<$Res> {
  __$$TripActivityImplCopyWithImpl(
      _$TripActivityImpl _value, $Res Function(_$TripActivityImpl) _then)
      : super(_value, _then);

  /// Create a copy of TripActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activityType = null,
    Object? estimatedStartTime = null,
    Object? estimatedEndTime = null,
    Object? locationDetails = freezed,
    Object? travelDetails = freezed,
  }) {
    return _then(_$TripActivityImpl(
      activityType: null == activityType
          ? _value.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as ActivityType,
      estimatedStartTime: null == estimatedStartTime
          ? _value.estimatedStartTime
          : estimatedStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      estimatedEndTime: null == estimatedEndTime
          ? _value.estimatedEndTime
          : estimatedEndTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      locationDetails: freezed == locationDetails
          ? _value.locationDetails
          : locationDetails // ignore: cast_nullable_to_non_nullable
              as LocationDetails?,
      travelDetails: freezed == travelDetails
          ? _value.travelDetails
          : travelDetails // ignore: cast_nullable_to_non_nullable
              as TravelDetails?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripActivityImpl implements _TripActivity {
  _$TripActivityImpl(
      {required this.activityType,
      required this.estimatedStartTime,
      required this.estimatedEndTime,
      this.locationDetails,
      this.travelDetails});

  factory _$TripActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripActivityImplFromJson(json);

  @override
  final ActivityType activityType;
  @override
  final DateTime estimatedStartTime;
  @override
  final DateTime estimatedEndTime;
  @override
  final LocationDetails? locationDetails;
  @override
  final TravelDetails? travelDetails;

  @override
  String toString() {
    return 'TripActivity(activityType: $activityType, estimatedStartTime: $estimatedStartTime, estimatedEndTime: $estimatedEndTime, locationDetails: $locationDetails, travelDetails: $travelDetails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripActivityImpl &&
            (identical(other.activityType, activityType) ||
                other.activityType == activityType) &&
            (identical(other.estimatedStartTime, estimatedStartTime) ||
                other.estimatedStartTime == estimatedStartTime) &&
            (identical(other.estimatedEndTime, estimatedEndTime) ||
                other.estimatedEndTime == estimatedEndTime) &&
            (identical(other.locationDetails, locationDetails) ||
                other.locationDetails == locationDetails) &&
            (identical(other.travelDetails, travelDetails) ||
                other.travelDetails == travelDetails));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, activityType, estimatedStartTime,
      estimatedEndTime, locationDetails, travelDetails);

  /// Create a copy of TripActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripActivityImplCopyWith<_$TripActivityImpl> get copyWith =>
      __$$TripActivityImplCopyWithImpl<_$TripActivityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TripActivityImplToJson(
      this,
    );
  }
}

abstract class _TripActivity implements TripActivity {
  factory _TripActivity(
      {required final ActivityType activityType,
      required final DateTime estimatedStartTime,
      required final DateTime estimatedEndTime,
      final LocationDetails? locationDetails,
      final TravelDetails? travelDetails}) = _$TripActivityImpl;

  factory _TripActivity.fromJson(Map<String, dynamic> json) =
      _$TripActivityImpl.fromJson;

  @override
  ActivityType get activityType;
  @override
  DateTime get estimatedStartTime;
  @override
  DateTime get estimatedEndTime;
  @override
  LocationDetails? get locationDetails;
  @override
  TravelDetails? get travelDetails;

  /// Create a copy of TripActivity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripActivityImplCopyWith<_$TripActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LocationDetails _$LocationDetailsFromJson(Map<String, dynamic> json) {
  return _LocationDetails.fromJson(json);
}

/// @nodoc
mixin _$LocationDetails {
  String get placeId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get editorialSummary => throw _privateConstructorUsedError;
  String? get formattedAddress => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  List<String> get openingHours => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get locationUrl => throw _privateConstructorUsedError;
  String? get locationImageUrl => throw _privateConstructorUsedError;

  /// Serializes this LocationDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationDetailsCopyWith<LocationDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationDetailsCopyWith<$Res> {
  factory $LocationDetailsCopyWith(
          LocationDetails value, $Res Function(LocationDetails) then) =
      _$LocationDetailsCopyWithImpl<$Res, LocationDetails>;
  @useResult
  $Res call(
      {String placeId,
      String name,
      String? editorialSummary,
      String? formattedAddress,
      double? latitude,
      double? longitude,
      List<String> openingHours,
      double rating,
      String? website,
      String? phoneNumber,
      String? locationUrl,
      String? locationImageUrl});
}

/// @nodoc
class _$LocationDetailsCopyWithImpl<$Res, $Val extends LocationDetails>
    implements $LocationDetailsCopyWith<$Res> {
  _$LocationDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? placeId = null,
    Object? name = null,
    Object? editorialSummary = freezed,
    Object? formattedAddress = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? openingHours = null,
    Object? rating = null,
    Object? website = freezed,
    Object? phoneNumber = freezed,
    Object? locationUrl = freezed,
    Object? locationImageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      editorialSummary: freezed == editorialSummary
          ? _value.editorialSummary
          : editorialSummary // ignore: cast_nullable_to_non_nullable
              as String?,
      formattedAddress: freezed == formattedAddress
          ? _value.formattedAddress
          : formattedAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      openingHours: null == openingHours
          ? _value.openingHours
          : openingHours // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      locationUrl: freezed == locationUrl
          ? _value.locationUrl
          : locationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      locationImageUrl: freezed == locationImageUrl
          ? _value.locationImageUrl
          : locationImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationDetailsImplCopyWith<$Res>
    implements $LocationDetailsCopyWith<$Res> {
  factory _$$LocationDetailsImplCopyWith(_$LocationDetailsImpl value,
          $Res Function(_$LocationDetailsImpl) then) =
      __$$LocationDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String placeId,
      String name,
      String? editorialSummary,
      String? formattedAddress,
      double? latitude,
      double? longitude,
      List<String> openingHours,
      double rating,
      String? website,
      String? phoneNumber,
      String? locationUrl,
      String? locationImageUrl});
}

/// @nodoc
class __$$LocationDetailsImplCopyWithImpl<$Res>
    extends _$LocationDetailsCopyWithImpl<$Res, _$LocationDetailsImpl>
    implements _$$LocationDetailsImplCopyWith<$Res> {
  __$$LocationDetailsImplCopyWithImpl(
      _$LocationDetailsImpl _value, $Res Function(_$LocationDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocationDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? placeId = null,
    Object? name = null,
    Object? editorialSummary = freezed,
    Object? formattedAddress = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? openingHours = null,
    Object? rating = null,
    Object? website = freezed,
    Object? phoneNumber = freezed,
    Object? locationUrl = freezed,
    Object? locationImageUrl = freezed,
  }) {
    return _then(_$LocationDetailsImpl(
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      editorialSummary: freezed == editorialSummary
          ? _value.editorialSummary
          : editorialSummary // ignore: cast_nullable_to_non_nullable
              as String?,
      formattedAddress: freezed == formattedAddress
          ? _value.formattedAddress
          : formattedAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      openingHours: null == openingHours
          ? _value._openingHours
          : openingHours // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      locationUrl: freezed == locationUrl
          ? _value.locationUrl
          : locationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      locationImageUrl: freezed == locationImageUrl
          ? _value.locationImageUrl
          : locationImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationDetailsImpl implements _LocationDetails {
  _$LocationDetailsImpl(
      {required this.placeId,
      required this.name,
      this.editorialSummary,
      this.formattedAddress,
      this.latitude,
      this.longitude,
      final List<String> openingHours = const [],
      this.rating = 0.0,
      this.website,
      this.phoneNumber,
      this.locationUrl,
      this.locationImageUrl})
      : _openingHours = openingHours;

  factory _$LocationDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationDetailsImplFromJson(json);

  @override
  final String placeId;
  @override
  final String name;
  @override
  final String? editorialSummary;
  @override
  final String? formattedAddress;
  @override
  final double? latitude;
  @override
  final double? longitude;
  final List<String> _openingHours;
  @override
  @JsonKey()
  List<String> get openingHours {
    if (_openingHours is EqualUnmodifiableListView) return _openingHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_openingHours);
  }

  @override
  @JsonKey()
  final double rating;
  @override
  final String? website;
  @override
  final String? phoneNumber;
  @override
  final String? locationUrl;
  @override
  final String? locationImageUrl;

  @override
  String toString() {
    return 'LocationDetails(placeId: $placeId, name: $name, editorialSummary: $editorialSummary, formattedAddress: $formattedAddress, latitude: $latitude, longitude: $longitude, openingHours: $openingHours, rating: $rating, website: $website, phoneNumber: $phoneNumber, locationUrl: $locationUrl, locationImageUrl: $locationImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationDetailsImpl &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.editorialSummary, editorialSummary) ||
                other.editorialSummary == editorialSummary) &&
            (identical(other.formattedAddress, formattedAddress) ||
                other.formattedAddress == formattedAddress) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            const DeepCollectionEquality()
                .equals(other._openingHours, _openingHours) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.locationUrl, locationUrl) ||
                other.locationUrl == locationUrl) &&
            (identical(other.locationImageUrl, locationImageUrl) ||
                other.locationImageUrl == locationImageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      placeId,
      name,
      editorialSummary,
      formattedAddress,
      latitude,
      longitude,
      const DeepCollectionEquality().hash(_openingHours),
      rating,
      website,
      phoneNumber,
      locationUrl,
      locationImageUrl);

  /// Create a copy of LocationDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationDetailsImplCopyWith<_$LocationDetailsImpl> get copyWith =>
      __$$LocationDetailsImplCopyWithImpl<_$LocationDetailsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationDetailsImplToJson(
      this,
    );
  }
}

abstract class _LocationDetails implements LocationDetails {
  factory _LocationDetails(
      {required final String placeId,
      required final String name,
      final String? editorialSummary,
      final String? formattedAddress,
      final double? latitude,
      final double? longitude,
      final List<String> openingHours,
      final double rating,
      final String? website,
      final String? phoneNumber,
      final String? locationUrl,
      final String? locationImageUrl}) = _$LocationDetailsImpl;

  factory _LocationDetails.fromJson(Map<String, dynamic> json) =
      _$LocationDetailsImpl.fromJson;

  @override
  String get placeId;
  @override
  String get name;
  @override
  String? get editorialSummary;
  @override
  String? get formattedAddress;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  List<String> get openingHours;
  @override
  double get rating;
  @override
  String? get website;
  @override
  String? get phoneNumber;
  @override
  String? get locationUrl;
  @override
  String? get locationImageUrl;

  /// Create a copy of LocationDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationDetailsImplCopyWith<_$LocationDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TravelDetails _$TravelDetailsFromJson(Map<String, dynamic> json) {
  return _TravelDetails.fromJson(json);
}

/// @nodoc
mixin _$TravelDetails {
  String get origin => throw _privateConstructorUsedError;
  String get destination => throw _privateConstructorUsedError;
  TravelMode get mode => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  double get distanceKm => throw _privateConstructorUsedError;

  /// Serializes this TravelDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TravelDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TravelDetailsCopyWith<TravelDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TravelDetailsCopyWith<$Res> {
  factory $TravelDetailsCopyWith(
          TravelDetails value, $Res Function(TravelDetails) then) =
      _$TravelDetailsCopyWithImpl<$Res, TravelDetails>;
  @useResult
  $Res call(
      {String origin,
      String destination,
      TravelMode mode,
      int durationMinutes,
      double distanceKm});
}

/// @nodoc
class _$TravelDetailsCopyWithImpl<$Res, $Val extends TravelDetails>
    implements $TravelDetailsCopyWith<$Res> {
  _$TravelDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TravelDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? destination = null,
    Object? mode = null,
    Object? durationMinutes = null,
    Object? distanceKm = null,
  }) {
    return _then(_value.copyWith(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as TravelMode,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      distanceKm: null == distanceKm
          ? _value.distanceKm
          : distanceKm // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TravelDetailsImplCopyWith<$Res>
    implements $TravelDetailsCopyWith<$Res> {
  factory _$$TravelDetailsImplCopyWith(
          _$TravelDetailsImpl value, $Res Function(_$TravelDetailsImpl) then) =
      __$$TravelDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String origin,
      String destination,
      TravelMode mode,
      int durationMinutes,
      double distanceKm});
}

/// @nodoc
class __$$TravelDetailsImplCopyWithImpl<$Res>
    extends _$TravelDetailsCopyWithImpl<$Res, _$TravelDetailsImpl>
    implements _$$TravelDetailsImplCopyWith<$Res> {
  __$$TravelDetailsImplCopyWithImpl(
      _$TravelDetailsImpl _value, $Res Function(_$TravelDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of TravelDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? destination = null,
    Object? mode = null,
    Object? durationMinutes = null,
    Object? distanceKm = null,
  }) {
    return _then(_$TravelDetailsImpl(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as TravelMode,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      distanceKm: null == distanceKm
          ? _value.distanceKm
          : distanceKm // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TravelDetailsImpl implements _TravelDetails {
  _$TravelDetailsImpl(
      {required this.origin,
      required this.destination,
      required this.mode,
      required this.durationMinutes,
      required this.distanceKm});

  factory _$TravelDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TravelDetailsImplFromJson(json);

  @override
  final String origin;
  @override
  final String destination;
  @override
  final TravelMode mode;
  @override
  final int durationMinutes;
  @override
  final double distanceKm;

  @override
  String toString() {
    return 'TravelDetails(origin: $origin, destination: $destination, mode: $mode, durationMinutes: $durationMinutes, distanceKm: $distanceKm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TravelDetailsImpl &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, origin, destination, mode, durationMinutes, distanceKm);

  /// Create a copy of TravelDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TravelDetailsImplCopyWith<_$TravelDetailsImpl> get copyWith =>
      __$$TravelDetailsImplCopyWithImpl<_$TravelDetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TravelDetailsImplToJson(
      this,
    );
  }
}

abstract class _TravelDetails implements TravelDetails {
  factory _TravelDetails(
      {required final String origin,
      required final String destination,
      required final TravelMode mode,
      required final int durationMinutes,
      required final double distanceKm}) = _$TravelDetailsImpl;

  factory _TravelDetails.fromJson(Map<String, dynamic> json) =
      _$TravelDetailsImpl.fromJson;

  @override
  String get origin;
  @override
  String get destination;
  @override
  TravelMode get mode;
  @override
  int get durationMinutes;
  @override
  double get distanceKm;

  /// Create a copy of TravelDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TravelDetailsImplCopyWith<_$TravelDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
