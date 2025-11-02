enum Role {
  admin,
  partner,
  client;

  static Role? fromString(String? value) {
    switch (value) {
      case 'ADMIN':
        return Role.admin;
      case 'PARTNER':
        return Role.partner;
      case 'CLIENT':
        return Role.client;
      default:
        return null;
    }
  }

  String toJson() {
    switch (this) {
      case Role.admin:
        return 'ADMIN';
      case Role.partner:
        return 'PARTNER';
      case Role.client:
        return 'CLIENT';
    }
  }
}

