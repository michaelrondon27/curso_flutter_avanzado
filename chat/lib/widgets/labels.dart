import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String route;
  final String subtitle;
  final String title;

  Labels({
    Key? key, 
    required this.route, 
    required this.subtitle, 
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            this.title,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w300
            )
          ),

          SizedBox( height: 10 ),

          GestureDetector(
            child: Text(
              this.subtitle,
              style: TextStyle(
                color: Colors.blue[600],
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            onTap: () => Navigator.pushReplacementNamed(context, this.route),
          )
        ]
      )
    );
  }
}
