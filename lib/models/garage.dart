class Garage {
  final int id;
  final String name;
  final String location;
  final int userId;
  final int like;
  final int unlike;
  final int rate;
  final String? comment;
  final String? logo;
  final String? banner;
  final String bio;
  final String createdAt;
  final String updatedAt;

  Garage({
    required this.id,
    required this.name,
    required this.location,
    required this.userId,
    required this.like,
    required this.unlike,
    required this.rate,
    this.comment,
    this.logo,
    this.banner,
    required this.bio,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Garage.fromJson(Map<String, dynamic> json) {
    return Garage(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      userId: json['user_id'],
      like: json['like'],
      unlike: json['unlike'],
      rate: json['rate'],
      comment: json['comment'],
      logo: json['logo'],
      banner: json['banner'],
      bio: json['bio'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
