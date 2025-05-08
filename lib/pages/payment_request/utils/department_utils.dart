// number_to_words.dart

// department_utils.dart
String getDepartmentName(int id) {
    switch (id) {
      case 1:
        return 'Sale';
      case 2:
        return 'Management';
      case 3:
        return 'Documentation department';
      default:
        return 'Không xác định';
    }
  }