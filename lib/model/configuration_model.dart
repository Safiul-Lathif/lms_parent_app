class ConfigurationModel {
  ConfigurationModel({
    required this.sameDevice,
    required this.screenDuration,
    required this.gameDuration,
    required this.learningDaysFrom,
    required this.learningDaysTo,
    required this.learningFromTime,
    required this.learningToTime,
    required this.nonAcademicDurationFrom,
    required this.nonAcademicDurationTo,
  });

  final String sameDevice;
  final String screenDuration;
  final String gameDuration;
  final String learningDaysFrom;
  final String learningDaysTo;
  final String learningFromTime;
  final String learningToTime;
  final String nonAcademicDurationFrom;
  final String nonAcademicDurationTo;

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) =>
      ConfigurationModel(
        sameDevice: json["same_device"],
        screenDuration: json["screen_duration"],
        gameDuration: json["game_duration"],
        learningDaysFrom: json["learning_days_from"],
        learningDaysTo: json["learning_days_to"],
        learningFromTime: json["learning_from_time"],
        learningToTime: json["learning_to_time"],
        nonAcademicDurationFrom: json["non_academic_duration_from"],
        nonAcademicDurationTo: json["non_academic_duration_to"],
      );

  Map<String, dynamic> toJson() => {
        "same_device": sameDevice,
        "screen_duration": screenDuration,
        "game_duration": gameDuration,
        "learning_days_from": learningDaysFrom,
        "learning_days_to": learningDaysTo,
        "learning_from_time": learningFromTime,
        "learning_to_time": learningToTime,
        "non_academic_duration_from": nonAcademicDurationFrom,
        "non_academic_duration_to": nonAcademicDurationTo,
      };
}
