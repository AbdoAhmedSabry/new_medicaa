class AppValidator {
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    final nameRegExp = RegExp(r"^[a-zA-Zأ-ي]+(?:\s+[a-zA-Zأ-ي]+)+$");
    if (!nameRegExp.hasMatch(value.trim())) {
      return 'Please enter at least your first and last name';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address is required';
    }
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegExp.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegExp = RegExp(r'^01[0125][0-9]{8}$');
    if (!phoneRegExp.hasMatch(value.trim())) {
      return 'Please enter a valid 11-digit Egyptian phone number';
    }
    return null;
  }

  static String? validateHeight(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Height is required';
    }
    final height = double.tryParse(value);
    if (height == null) return 'Please enter a valid number';
    if (height < 30 || height > 250) {
      return 'Enter a realistic height (30-250 cm)';
    }
    return null;
  }

  static String? validateWeight(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Weight is required';
    }
    final weight = double.tryParse(value);
    if (weight == null) return 'Please enter a valid number';
    if (weight < 2 || weight > 300) {
      return 'Enter a realistic weight (2-300 kg)';
    }
    return null;
  }

  static String? validateAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Age is required';
    }
    final age = int.tryParse(value);
    if (age == null) return 'Please enter a valid number';
    if (age < 0 || age > 120) return 'Please enter a valid age';
    return null;
  }
  
}
