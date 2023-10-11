class FaqModel {
  int? id;
  String? question;
  String? answer;
  int? section;

  FaqModel({this.id, this.question, this.answer});

  FaqModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    section = json['section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> FaqModel = new Map<String, dynamic>();
    FaqModel['id'] = this.id;
    FaqModel['question'] = this.question;
    FaqModel['answer'] = this.answer;
    FaqModel['section'] = this.section;
    return FaqModel;
  }
}
