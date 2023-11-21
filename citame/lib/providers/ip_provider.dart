import 'package:flutter_riverpod/flutter_riverpod.dart';

final ipProvider = StateNotifierProvider<IpNotifier, String>((ref) {
  return IpNotifier();
});

class IpNotifier extends StateNotifier<String> {
  IpNotifier() : super('http://192.168.0.6:4000');
}
