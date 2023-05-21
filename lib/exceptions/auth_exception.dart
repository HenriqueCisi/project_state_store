class AuthException implements Exception {
  final String key;
  static const Map<String,String> errors = {
    'EMAIL_NOT_FOUND': 'Email não encontrado',
    'INVALID_PASSWORD': 'Senha inválida',
    'USER_DISABLED': 'A conta do usuário foi desabilitada',
    'EMAIL_EXISTS': 'Email já cadastrado',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida!',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Acesso bloqueado temporariamente, tente mais tarde',
  };

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'Ocorreu um erro no processo de autenticação';
  }
}