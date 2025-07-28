// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      description: json['description'] as String?,
      profilePicUrl: json['profilePicUrl'] as String?,
      badgesUrls: (json['badgesUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      gamePoints: (json['gamePoints'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'description': instance.description,
      'profilePicUrl': instance.profilePicUrl,
      'badgesUrls': instance.badgesUrls,
      'gamePoints': instance.gamePoints,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      postType: $enumDecode(_$PostTypeEnumMap, json['postType']),
      imageUrls:
          (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      creator: User.fromJson(json['creator'] as Map<String, dynamic>),
      likesCount: (json['likesCount'] as num).toInt(),
      commentsCount: (json['commentsCount'] as num).toInt(),
      destination:
          Destination.fromJson(json['destination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'postType': _$PostTypeEnumMap[instance.postType]!,
      'imageUrls': instance.imageUrls,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'creator': instance.creator,
      'likesCount': instance.likesCount,
      'commentsCount': instance.commentsCount,
      'destination': instance.destination,
    };

const _$PostTypeEnumMap = {
  PostType.post: 'post',
  PostType.experience: 'experience',
  PostType.questions: 'questions',
  PostType.tips: 'tips',
};

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      id: json['id'] as String,
      postId: json['postId'] as String,
      content: json['content'] as String,
      replies: (json['replies'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'content': instance.content,
      'replies': instance.replies,
      'createdAt': instance.createdAt.toIso8601String(),
      'user': instance.user,
    };

_$LikeImpl _$$LikeImplFromJson(Map<String, dynamic> json) => _$LikeImpl(
      id: json['id'] as String,
      postId: json['postId'] as String,
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$LikeImplToJson(_$LikeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$DestinationImpl _$$DestinationImplFromJson(Map<String, dynamic> json) =>
    _$DestinationImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$DestinationImplToJson(_$DestinationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$TripPlanImpl _$$TripPlanImplFromJson(Map<String, dynamic> json) =>
    _$TripPlanImpl(
      planTitle: json['planTitle'] as String,
      overview: json['overview'] as String,
      warnings:
          (json['warnings'] as List<dynamic>).map((e) => e as String).toList(),
      tripStartDate: DateTime.parse(json['tripStartDate'] as String),
      tripEndDate: DateTime.parse(json['tripEndDate'] as String),
      dailyItineraryList: (json['dailyItineraryList'] as List<dynamic>)
          .map((e) => DailyItinerary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TripPlanImplToJson(_$TripPlanImpl instance) =>
    <String, dynamic>{
      'planTitle': instance.planTitle,
      'overview': instance.overview,
      'warnings': instance.warnings,
      'tripStartDate': instance.tripStartDate.toIso8601String(),
      'tripEndDate': instance.tripEndDate.toIso8601String(),
      'dailyItineraryList': instance.dailyItineraryList,
    };

_$DailyItineraryImpl _$$DailyItineraryImplFromJson(Map<String, dynamic> json) =>
    _$DailyItineraryImpl(
      date: DateTime.parse(json['date'] as String),
      daySummary: json['daySummary'] as String,
      warnings: json['warnings'] as String?,
      activityList: (json['activityList'] as List<dynamic>)
          .map((e) => TripActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DailyItineraryImplToJson(
        _$DailyItineraryImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'daySummary': instance.daySummary,
      'warnings': instance.warnings,
      'activityList': instance.activityList,
    };

_$TripActivityImpl _$$TripActivityImplFromJson(Map<String, dynamic> json) =>
    _$TripActivityImpl(
      activityType: $enumDecode(_$ActivityTypeEnumMap, json['activityType']),
      estimatedStartTime: DateTime.parse(json['estimatedStartTime'] as String),
      estimatedEndTime: DateTime.parse(json['estimatedEndTime'] as String),
      locationDetails: json['locationDetails'] == null
          ? null
          : LocationDetails.fromJson(
              json['locationDetails'] as Map<String, dynamic>),
      travelDetails: json['travelDetails'] == null
          ? null
          : TravelDetails.fromJson(
              json['travelDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TripActivityImplToJson(_$TripActivityImpl instance) =>
    <String, dynamic>{
      'activityType': _$ActivityTypeEnumMap[instance.activityType]!,
      'estimatedStartTime': instance.estimatedStartTime.toIso8601String(),
      'estimatedEndTime': instance.estimatedEndTime.toIso8601String(),
      'locationDetails': instance.locationDetails,
      'travelDetails': instance.travelDetails,
    };

const _$ActivityTypeEnumMap = {
  ActivityType.destination: 'destination',
  ActivityType.travel: 'travel',
};

_$LocationDetailsImpl _$$LocationDetailsImplFromJson(
        Map<String, dynamic> json) =>
    _$LocationDetailsImpl(
      placeId: json['placeId'] as String,
      name: json['name'] as String,
      editorialSummary: json['editorialSummary'] as String?,
      formattedAddress: json['formattedAddress'] as String?,
      openingHours: (json['openingHours'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      website: json['website'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      locationUrl: json['locationUrl'] as String?,
      locationImageUrl: json['locationImageUrl'] as String?,
    );

Map<String, dynamic> _$$LocationDetailsImplToJson(
        _$LocationDetailsImpl instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'name': instance.name,
      'editorialSummary': instance.editorialSummary,
      'formattedAddress': instance.formattedAddress,
      'openingHours': instance.openingHours,
      'rating': instance.rating,
      'website': instance.website,
      'phoneNumber': instance.phoneNumber,
      'locationUrl': instance.locationUrl,
      'locationImageUrl': instance.locationImageUrl,
    };

_$TravelDetailsImpl _$$TravelDetailsImplFromJson(Map<String, dynamic> json) =>
    _$TravelDetailsImpl(
      origin: json['origin'] as String,
      destination: json['destination'] as String,
      mode: $enumDecode(_$TravelModeEnumMap, json['mode']),
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      distanceKm: (json['distanceKm'] as num).toDouble(),
    );

Map<String, dynamic> _$$TravelDetailsImplToJson(_$TravelDetailsImpl instance) =>
    <String, dynamic>{
      'origin': instance.origin,
      'destination': instance.destination,
      'mode': _$TravelModeEnumMap[instance.mode]!,
      'durationMinutes': instance.durationMinutes,
      'distanceKm': instance.distanceKm,
    };

const _$TravelModeEnumMap = {
  TravelMode.DRIVING: 'DRIVING',
  TravelMode.WALKING: 'WALKING',
};
