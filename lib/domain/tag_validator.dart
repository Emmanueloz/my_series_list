class TagValidator {
  static String? isValidName(String? name) {
    if (name == null || name.isEmpty) {
      return "Name is required";
    } else if (name.length > 20) {
      return "Name is too long";
    }
    return null;
  }

  static String? isValidColor(String? color) {
    // 0xfffa5252 or 0xff099268
    String colorPattern = r'^0x[0-9a-fA-F]{8}$';

    RegExp regExp = RegExp(colorPattern);

    if (color == null || color.isEmpty) {
      return "Color is required";
    } else if (!regExp.hasMatch(color)) {
      return "Color is not valid";
    }
    return null;
  }
}
