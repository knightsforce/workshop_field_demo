enum FieldId {
  name,
  lastName,
  email,
}

extension FieldIdValue on FieldId {
  String get value {
    switch (this) {
      case FieldId.name:
        return 'name';
      case FieldId.lastName:
        return 'lastName';
      case FieldId.email:
        return 'email';
    }
    return '';
  }
}
