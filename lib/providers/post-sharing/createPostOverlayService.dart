import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'createPostOverlayService.g.dart';

@riverpod
class CreatePostOverlayService extends _$CreatePostOverlayService {
  @override
  bool build() {
    return false; // Initially not shown
  }

  void show() {
    state = true;
  }

  void hide() {
    state = false;
  }
}
