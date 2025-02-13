class FaqResponse {
  final List<Faq> faqs;

  FaqResponse({
    required this.faqs,
  });

  factory FaqResponse.fromJson(Map<String, dynamic> json) {
    return FaqResponse(
      faqs: (json['FAQs'] as List).map((faq) => Faq.fromJson(faq)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FAQs': faqs.map((faq) => faq.toJson()).toList(),
    };
  }
}

class Faq {
  final String id;
  final String question;
  final String answer;

  Faq({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(
      id: json['_id'],
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'question': question,
      'answer': answer,
    };
  }
}
