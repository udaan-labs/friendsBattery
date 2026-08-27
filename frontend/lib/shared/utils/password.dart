const passwordRuleMsg =
    'Password must be at least 8 characters, with one uppercase letter and one special character';

/// Returns [passwordRuleMsg] if invalid, otherwise null.
String? validateStrongPassword(String password) {
  if (password.length < 8 ||
      !RegExp(r'[A-Z]').hasMatch(password) ||
      !RegExp(r'[^A-Za-z0-9]').hasMatch(password)) {
    return passwordRuleMsg;
  }
  return null;
}
