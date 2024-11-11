class Email {
  final String value;

  Email(this.value) {
    if (!_isValidEmail(value)) {
      throw Exception('Invalid email format');
    }
  }

  bool _isValidEmail(String email) {
    // Add email validation logic
    return true; // Simplified for example
  }
}