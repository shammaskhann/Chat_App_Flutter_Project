import 'package:flutter/material.dart';
import 'package:flutter_firebase_project_app/constant/colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPressed;
  const CustomButton(
      {required this.title,
      required this.loading,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
      child: InkWell(
        onTap: () {
          onPressed();
        },
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.luminousGreen,
                AppColors.glowingCyan,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: (loading)
                ? const CircularProgressIndicator()
                : Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Mont',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
