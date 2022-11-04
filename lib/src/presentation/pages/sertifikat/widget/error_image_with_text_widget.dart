import 'package:flutter/material.dart';

class ErrorImageWithTextWidget extends StatelessWidget {
  const ErrorImageWithTextWidget({
    Key? key,
    required this.errorMsg,
    required this.refreshBtn,
  }) : super(key: key);

  final String errorMsg;
  final VoidCallback refreshBtn;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 25,
        ),
        Icon(
          Icons.running_with_errors_rounded,
          size: 125,
          color: Colors.grey.shade500,
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          errorMsg,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () => refreshBtn(),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
          child: const Text(
            'Refresh',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
