bool isEmailValid(String email) {
  // TODO: Improve email validation, use package or pattern?
  if (email.length >= 3 && email.contains('@')) return true;
  return false;
}

bool isUsernameValid(String username) {
  if (username.length >= 3) return true;
  return false;
}

bool isPasswordValid(String password) {
  if (password.length >= 3) return true;
  return false;
}

bool isRePasswordValid(String password ,String rePassword) {
  if (isPasswordValid(rePassword) && password == rePassword) return true;
  return false;
}
