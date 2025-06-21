// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentService.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$commentServiceHash() => r'49f50c826f924acf55b80264c0fc29e4078b6d22';

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

abstract class _$CommentService
    extends BuildlessAutoDisposeAsyncNotifier<List<Comment>> {
  late final int postId;

  FutureOr<List<Comment>> build(
    int postId,
  );
}

/// See also [CommentService].
@ProviderFor(CommentService)
const commentServiceProvider = CommentServiceFamily();

/// See also [CommentService].
class CommentServiceFamily extends Family<AsyncValue<List<Comment>>> {
  /// See also [CommentService].
  const CommentServiceFamily();

  /// See also [CommentService].
  CommentServiceProvider call(
    int postId,
  ) {
    return CommentServiceProvider(
      postId,
    );
  }

  @override
  CommentServiceProvider getProviderOverride(
    covariant CommentServiceProvider provider,
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
  String? get name => r'commentServiceProvider';
}

/// See also [CommentService].
class CommentServiceProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CommentService, List<Comment>> {
  /// See also [CommentService].
  CommentServiceProvider(
    int postId,
  ) : this._internal(
          () => CommentService()..postId = postId,
          from: commentServiceProvider,
          name: r'commentServiceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$commentServiceHash,
          dependencies: CommentServiceFamily._dependencies,
          allTransitiveDependencies:
              CommentServiceFamily._allTransitiveDependencies,
          postId: postId,
        );

  CommentServiceProvider._internal(
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
  FutureOr<List<Comment>> runNotifierBuild(
    covariant CommentService notifier,
  ) {
    return notifier.build(
      postId,
    );
  }

  @override
  Override overrideWith(CommentService Function() create) {
    return ProviderOverride(
      origin: this,
      override: CommentServiceProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<CommentService, List<Comment>>
      createElement() {
    return _CommentServiceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CommentServiceProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CommentServiceRef on AutoDisposeAsyncNotifierProviderRef<List<Comment>> {
  /// The parameter `postId` of this provider.
  int get postId;
}

class _CommentServiceProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CommentService,
        List<Comment>> with CommentServiceRef {
  _CommentServiceProviderElement(super.provider);

  @override
  int get postId => (origin as CommentServiceProvider).postId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
