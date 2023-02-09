class StudentProgress {
  StudentProgress({
    required this.unitId,
    required this.unitName,
    required this.unitOrder,
    required this.unitBenefits,
    required this.parentTip,
    required this.questionsCount,
    required this.time,
    required this.wrongAnswer,
    required this.correctAnswer,
    required this.status,
  });

  final String unitId;
  final String unitName;
  final String unitOrder;
  final String unitBenefits;
  final String parentTip;
  final String questionsCount;
  final String time;
  final int wrongAnswer;
  final int correctAnswer;
  final String status;

  factory StudentProgress.fromJson(Map<String, dynamic> json) =>
      StudentProgress(
        unitId: json["unit_id"],
        unitName: json["unit_name"],
        unitOrder: json["unit_order"],
        unitBenefits: json["unit_benefits"],
        parentTip: json["parent_tip"],
        questionsCount: json["questions_count"],
        time: json["time"],
        wrongAnswer: json["wrong_answer"],
        correctAnswer: json["correct_answer"],
        status: json["status"],
      );
}
