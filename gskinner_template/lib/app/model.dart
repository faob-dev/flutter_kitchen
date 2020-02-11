import 'package:flutter/material.dart';

class CardModel {
  final String title;
  final String description;
  final Color color;
  final Icon icon;
  final String buttonText;

  CardModel({
    this.title,
    this.description,
    this.color,
    this.icon,
    String buttonText,
  }) : this.buttonText = buttonText?.toUpperCase();
}

List<CardModel> loadCards({double iconSize}) {
  List<CardModel> cards = [
    CardModel(
      title: "Digital Innovators",
      description:
          "When it comes to delivering bleeding edge digital solutions, top brands in technology, sports, and entertainment trust our team of designers, developers, and strategic thinkers to get the job done.",
      color: Color(0xFF5f6caf),
      icon: Icon(Icons.laptop_mac,
          size: iconSize, color: Colors.white.withOpacity(0.2)),
      buttonText: "Project Showcase",
    ),
    CardModel(
      title: "Dependably Creative",
      description:
          "Our clients choose us for our innovation, and stay for our ability to successfully deliver on time and budget. In 15 years and hundreds of challenging projects, we haven’t had one major hiccup.",
      color: Color(0xFF17bebb),
      icon: Icon(Icons.phone_android,
          size: iconSize, color: Colors.white.withOpacity(0.2)),
      buttonText: "More About Us",
    ),
    CardModel(
      title: "Areas Of Expertise",
      description:
          "Virtual Reality, Digital Experiences, Web Solutions, Native Apps, Libraries & Frameworks and Customized Tools.",
      color: Color(0xFFff5959),
      icon: Icon(Icons.headset,
          size: iconSize, color: Colors.white.withOpacity(0.2)),
    ),
    CardModel(
      title: "Let’s Chat",
      description:
          "We love what we do—a lot. This passion has enabled us to work with some of the world’s top agencies and clients. Talk to us today to find out how we can apply our passion to your next project.",
      color: Color(0xFF00649f),
      icon: Icon(Icons.watch,
          size: iconSize, color: Colors.white.withOpacity(0.2)),
      buttonText: "Say Hello",
    ),
    CardModel(
      title: "Practicing Our Craft",
      description:
          "We’ve always been huge believers in exploring and experimenting with new technologies, ideas and trends. This helps us continually develop our skills and push the limits for our clients.",
      color: Color(0xFFffba5a),
      icon: Icon(Icons.alarm,
          size: iconSize, color: Colors.white.withOpacity(0.2)),
      buttonText: "The Lab",
    ),
    CardModel(
      title: "Join the Team",
      description:
          "If you like creating awesome, innovative solutions for smart companies and collaborating with a fun and super talented team, we’d love to hear from you.",
      color: Color(0xFF5c5757),
      icon: Icon(Icons.public,
          size: iconSize, color: Colors.white.withOpacity(0.2)),
      buttonText: "Careers At GSkinner",
    ),
  ];

  return cards;
}
