import 'package:flutter/material.dart';
import 'package:kiuf_quiz/utils/rgb.dart';

class CustomLoadingWidget extends StatelessWidget {
  CustomLoadingWidget({
    this.total = 0,
    this.count = 0,
    super.key,
  });

  int total;
  int count;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: total != 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox.square(
                  dimension: 100,
                  child: CircularProgressIndicator(
                    color: RGB.primary.withAlpha(200),
                    backgroundColor: RGB.grey.withAlpha(100),
                    strokeWidth: 7,
                    value: 1.0 / total * count,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total: $count / $total",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: RGB.black.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : SizedBox.square(
              dimension: 100,
              child: CircularProgressIndicator(
                color: RGB.primary.withAlpha(200),
              ),
            ),
    );
  }
}
