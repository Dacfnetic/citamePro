import 'package:flutter_riverpod/flutter_riverpod.dart';

final reRenderProvider = StateNotifierProvider<ReRenderNotifier, bool>((ref) {
  return ReRenderNotifier();
});

class ReRenderNotifier extends StateNotifier<bool> {
  ReRenderNotifier() : super(false);

  void reRender() {
    state = !state;
  }
}
