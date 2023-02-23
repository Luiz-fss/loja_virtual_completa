String pegarTextoErro(String codigoErro){
  switch (codigoErro){
    case 'ERROR_WEAK_PASSWORD':
      return "Senha fraca.";
    case 'ERROR_INVALID_EMAIL':
      return "Seu E-mail é inválido.";
    case 'ERROR_EMAIL_ALREADY_USE':
      return "Este e-mail já está sendo usado.";
    case 'ERROR_INVALID_CREDENTIAL':
      return "Seu e-mail é inválido.";
    case 'ERROR_WRONG_PASSWORD':
      return "Senha incorreta.";
    case 'ERROR_USER_NOT_FOUND':
      return "Usuário não encontrado.";
    case 'ERROR_USER_DISABLE':
      return "Este usuário foi desativado.";
    case 'ERROR_TOO_MANY_REQUESTS':
      return "Muitas solicitações. Tente novamente mais tarde.";
    case 'ERROR_OPERATION_NOT_ALLOWED':
      return "Operação não permitida.";
    default:
      return "Um erro indefinido aconteceu.";

  }
}