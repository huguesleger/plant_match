import 'package:flutter/material.dart';
import '../../app_colors.dart';

class MyBottomSheet {
  static void showBottomSheet(
      BuildContext context, Widget child, double height, String? title) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
            height: height,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 50,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                title != null
                    ? Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              title,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                child,
              ],
            ));
      },
    );
  }
}
