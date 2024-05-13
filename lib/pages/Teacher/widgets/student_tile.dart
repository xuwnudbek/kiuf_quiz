import 'package:flutter/material.dart';
import 'package:kiuf_quiz/providers/teacher/check_results_provider.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:provider/provider.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({
    super.key,
    required this.student,
    required this.selected,
  });

  final Map student;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckResultsProvider>(builder: (context, provider, _) {
      return GestureDetector(
        onTap: () {
          provider.setStudent(student);
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: selected ? RGB.primary : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 6.0,
          ),
          margin: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student['name'],
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: selected ? RGB.white : RGB.primary,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "ID: ${student['loginId']}",
                      style: TextStyle(
                        color: selected ? RGB.white : RGB.primary,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}




/*
  {
      "loginId": 2223141009,
      "name": "Abdusamatov Xushnudbek Murodiljon o`g`li",
      "faculty": "Internet va axborot kommunikatsiyasi",
      "passportNumber": "AD0353490",
      "course": 2,
      "created_at": "2024-04-23T17:46:11.000000Z",
      "updated_at": "2024-04-23T17:46:11.000000Z"
  },
*/
