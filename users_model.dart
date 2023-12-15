class Users {
  List<Result> results;

  Users({
    required this.results,
  });
}

class Result {
  String gender;

  Name name;

  String email;

  String phone;

  Picture picture;

  Result({
    required this.gender,
    required this.name,
    required this.email,
    required this.phone,
    required this.picture,
  });
}

class Name {
  String title;

  String first;

  String last;

  Name({
    required this.title,
    required this.first,
    required this.last,
  });
}

class Picture {
  String thumbnail;

  Picture({
    required this.thumbnail,
  });
}
