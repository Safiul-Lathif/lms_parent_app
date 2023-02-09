class LoginDetails {
  LoginDetails({
    required this.parentName,
    required this.wardName,
    required this.userCategory,
    required this.courseConfigured,
    required this.completionPercentage,
    required this.contentUsage,
  });

  final String parentName;
  final String wardName;
  final String userCategory;
  final String courseConfigured;
  final String completionPercentage;
  final String contentUsage;

  factory LoginDetails.fromJson(Map<String, dynamic> json) => LoginDetails(
        parentName: json["parent_name"],
        wardName: json["ward_name"],
        userCategory: json["user_category"],
        courseConfigured: json["course_configured"],
        completionPercentage: json["completion_percentage"],
        contentUsage: json["content_usage"],
      );

  Map<String, dynamic> toJson() => {
        "parent_name": parentName,
        "ward_name": wardName,
        "user_category": userCategory,
        "course_configured": courseConfigured,
        "completion_percentage": completionPercentage,
        "content_usage": contentUsage,
      };
}
