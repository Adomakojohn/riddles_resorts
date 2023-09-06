class Riddle {
  final String title;
  final String question;
  final String answer;

  Riddle({required this.question, required this.answer , required this.title});

  factory Riddle.fromJson(Map<String, dynamic> json) {
    return Riddle(
      title: json['title'],
      question: json['question'],
      answer: json['answer'],
    );
  }
}