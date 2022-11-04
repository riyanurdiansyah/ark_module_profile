import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SertifikatEmptyWidget extends StatelessWidget {
  const SertifikatEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 2,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty_state.png',
            width: 125,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Sertifikat tidak ditemukan',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
