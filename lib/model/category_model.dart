class Category {
  Category({
    required this.categoryId,
    required this.categoryName,
  });

  final String categoryId;
  final String categoryName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
      };
}

class LevelList {
  LevelList({
    required this.levelId,
    required this.levelName,
  });

  final String levelId;
  final String levelName;

  factory LevelList.fromJson(Map<String, dynamic> json) => LevelList(
        levelId: json["level_id"],
        levelName: json["level_name"],
      );

  Map<String, dynamic> toJson() => {
        "level_id": levelId,
        "level_name": levelName,
      };
}
