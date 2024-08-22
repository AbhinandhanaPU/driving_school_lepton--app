import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';

class StudentReviewHome extends StatefulWidget {
  const StudentReviewHome({super.key});

  @override
  _StudentReviewHomeState createState() => _StudentReviewHomeState();
}

class _StudentReviewHomeState extends State<StudentReviewHome> {
  String? selectedReview; // Variable to hold the selected review option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cblue,
        title: const Text('Student Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rate the Student:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Checkbox(
                  value: selectedReview == 'Bad',
                  onChanged: (bool? value) {
                    setState(() {
                      selectedReview = value! ? 'Bad' : null;
                    });
                  },
                ),
                const Text('Bad'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: selectedReview == 'Good',
                  onChanged: (bool? value) {
                    setState(() {
                      selectedReview = value! ? 'Good' : null;
                    });
                  },
                ),
                const Text('Good'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: selectedReview == 'Excellent',
                  onChanged: (bool? value) {
                    setState(() {
                      selectedReview = value! ? 'Excellent' : null;
                    });
                  },
                ),
                const Text('Excellent'),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Student Review:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter review here',
              ),
              maxLines: 3,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextButton(
                  onPressed: () {
                    // Add your update logic here
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: cblack,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
