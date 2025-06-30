// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'likeService.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$likeServiceHash() => r'a0ae276d8b302cd22c30a7d8f70c54e036cb5a2b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$LikeService extends BuildlessAsyncNotifier<PostLikeData> {
  late final int postId;

  FutureOr<PostLikeData> build(
    int postId,
  );
}

/// See also [LikeService].
@ProviderFor(LikeService)
const likeServiceProvider = LikeServiceFamily();

/// See also [LikeService].
class LikeServiceFamily extends Family<AsyncValue<PostLikeData>> {
  /// See also [LikeService].
  const LikeServiceFamily();

  /// See also [LikeService].
  LikeServiceProvider call(
    int postId,
  ) {
    return LikeServiceProvider(
      postId,
    );
  }

  @override
  LikeServiceProvider getProviderOverride(
    covariant LikeServiceProvider provider,
  ) {
    return call(
      provider.postId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'likeServiceProvider';
}

/// See also [LikeService].
class LikeServiceProvider
    extends AsyncNotifierProviderImpl<LikeService, PostLikeData> {
  /// See also [LikeService].
  LikeServiceProvider(
    int postId,
  ) : this._internal(
          () => LikeService()..postId = postId,
          from: likeServiceProvider,
          name: r'likeServiceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$likeServiceHash,
          dependencies: LikeServiceFamily._dependencies,
          allTransitiveDependencies:
              LikeServiceFamily._allTransitiveDependencies,
          postId: postId,
        );

  LikeServiceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
  }) : super.internal();

  final int postId;

  @override
  FutureOr<PostLikeData> runNotifierBuild(
    covariant LikeService notifier,
  ) {
    return notifier.build(
      postId,
    );
  }

  @override
  Override overrideWith(LikeService Function() create) {
    return ProviderOverride(
      origin: this,
      override: LikeServiceProvider._internal(
        () => create()..postId = postId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<LikeService, PostLikeData> createElement() {
    return _LikeServiceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LikeServiceProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LikeServiceRef on AsyncNotifierProviderRef<PostLikeData> {
  /// The parameter `postId` of this provider.
  int get postId;
}

class _LikeServiceProviderElement
    extends AsyncNotifierProviderElement<LikeService, PostLikeData>
    with LikeServiceRef {
  _LikeServiceProviderElement(super.provider);

  @override
  int get postId => (origin as LikeServiceProvider).postId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
