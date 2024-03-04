import 'package:flutter/material.dart';
import 'package:weather_info_app/utils/constants/sizes.dart';
import 'package:weather_info_app/utils/constants/text_strings.dart';

class ErrorPage extends StatelessWidget {
  String? errorMessage;

  ErrorPage({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
          padding: EdgeInsets.all(AppSizes.spaceBetweenItems),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  errorMessage ?? AppTexts.defaultFailureText,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: AppSizes.spaceBetweenItems),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(AppTexts.retryText),
                ),
              ],
            ),
          )),
    );
  }
}
