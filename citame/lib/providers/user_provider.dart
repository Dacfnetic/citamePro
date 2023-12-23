import 'package:citame/models/user_model.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UsuarioNotifier, Usuario>((ref) {
  return UsuarioNotifier();
});

class UsuarioNotifier extends StateNotifier<Usuario> {
  UsuarioNotifier()
      : super(Usuario(googleId: '', userName: '', userEmail: '', avatar: ''));

  void cargar() async {
    Usuario usuario;
    usuario = await API.getUser();
    email = usuario.userEmail;
    state = usuario;
  }

  void setEmail(entrada) {
    email = entrada;
  }

  String getEmail() {
    return email;
  }
}

String email = '';
