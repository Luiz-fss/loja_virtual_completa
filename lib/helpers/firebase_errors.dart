String getErrorString(String codigoErro){
  switch (codigoErro){
    case 'WEAK-PASSWORD':
      return "Senha fraca.";
    case 'INVALID-EMAIL':
      return "Seu E-mail é inválido.";
    case 'EMAIL-ALREADY-USE':
      return "Este e-mail já está sendo usado.";
    case 'INVALID-CREDENTIAL':
      return "Seu e-mail é inválido.";
    case 'WRONG-PASSWORD':
      return "Senha incorreta.";
    case 'USER-NOT-FOUND':
      return "Usuário não encontrado.";
    case 'USER-DISABLE':
      return "Este usuário foi desativado.";
    case 'TOO-MANY-REQUESTS':
      return "Muitas solicitações. Tente novamente mais tarde.";
    case 'OPERATION-NOT-ALLOWED':
      return "Operação não permitida.";
    default:
      return "Um erro indefinido aconteceu.";

  }
}