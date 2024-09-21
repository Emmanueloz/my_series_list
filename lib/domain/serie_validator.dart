import 'package:my_series_list/domain/tag.dart';

class SerieValidator {
  static String? isValidName(String? name) {
    if (name!.isEmpty) {
      return "Name can't be empty";
    } else if (name.length > 100) {
      return "Name can't be longer than 100 characters";
    }

    return null;
  }

  static String? isValidDescription(String? description) {
    if (description!.isEmpty) {
      return null;
    } else if (description.length > 1000) {
      return "Description can't be longer than 1000 characters";
    } else if (description.contains("\n")) {
      return "Description can't contain new lines";
    }

    return null;
  }

  static String? isValidUrl(String? url) {
    String urlPattern =
        r'^(https?:\/\/)?(www\.)?([a-zA-Z0-9-]{1,63}\.)+[a-zA-Z]{2,6}(\/.*)?$';

    RegExp regExp = RegExp(urlPattern);

    if (url!.isEmpty) {
      return null;
    } else if (!regExp.hasMatch(url)) {
      return "URL is not valid";
    }

    return null;
  }

  static String? isValidTags(List<Tag> tags) {
    if (tags.isEmpty) {
      return "You must add at least one tag";
    } else if (tags.length > 10) {
      return "You can't add more than 10 tags";
    }
    return null;
  }
}
