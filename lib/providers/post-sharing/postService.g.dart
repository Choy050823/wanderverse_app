// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postService.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postServiceHash() => r'9d79c4fc17335c69ef7323fe966710f10d61b777';

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

abstract class _$PostService extends BuildlessNotifier<PostsState> {
  late final PostApiType type;
  late final String destinationId;

  PostsState build(
    PostApiType type,
    String destinationId,
  );
}

/// See also [PostService].
@ProviderFor(PostService)
const postServiceProvider = PostServiceFamily();

/// See also [PostService].
class PostServiceFamily extends Family<PostsState> {
  /// See also [PostService].
  const PostServiceFamily();

  /// See also [PostService].
  PostServiceProvider call(
    PostApiType type,
    String destinationId,
  ) {
    return PostServiceProvider(
      type,
      destinationId,
    );
  }

  @override
  PostServiceProvider getProviderOverride(
    covariant PostServiceProvider provider,
  ) {
    return call(
      provider.type,
      provider.destinationId,
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
  String? get name => r'postServiceProvider';
}

/// See also [PostService].
class PostServiceProvider
    extends NotifierProviderImpl<PostService, PostsState> {
  /// See also [PostService].
  PostServiceProvider(
    PostApiType type,
    String destinationId,
  ) : this._internal(
          () => PostService()
            ..type = type
            ..destinationId = destinationId,
          from: postServiceProvider,
          name: r'postServiceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postServiceHash,
          dependencies: PostServiceFamily._dependencies,
          allTransitiveDependencies:
              PostServiceFamily._allTransitiveDependencies,
          type: type,
          destinationId: destinationId,
        );

  PostServiceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
    required this.destinationId,
  }) : super.internal();

  final PostApiType type;
  final String destinationId;

  @override
  PostsState runNotifierBuild(
    covariant PostService notifier,
  ) {
    return notifier.build(
      type,
      destinationId,
    );
  }

  @override
  Override overrideWith(PostService Function() create) {
    return ProviderOverride(
      origin: this,
      override: PostServiceProvider._internal(
        () => create()
          ..type = type
          ..destinationId = destinationId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
        destinationId: destinationId,
      ),
    );
  }

  @override
  NotifierProviderElement<PostService, PostsState> createElement() {
    return _PostServiceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostServiceProvider &&
        other.type == type &&
        other.destinationId == destinationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, destinationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostServiceRef on NotifierProviderRef<PostsState> {
  /// The parameter `type` of this provider.
  PostApiType get type;

  /// The parameter `destinationId` of this provider.
  String get destinationId;
}

class _PostServiceProviderElement
    extends NotifierProviderElement<PostService, PostsState>
    with PostServiceRef {
  _PostServiceProviderElement(super.provider);

  @override
  PostApiType get type => (origin as PostServiceProvider).type;
  @override
  String get destinationId => (origin as PostServiceProvider).destinationId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
